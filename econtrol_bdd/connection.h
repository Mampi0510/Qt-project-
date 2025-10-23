#ifndef CONNECTION_H
#define CONNECTION_H

#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QCoreApplication>
#include <QTimer>
#include <QThread>
#include <QFile>
#include <QTextStream>

static QProcess *mysqlProcess = nullptr;

static bool startEmbeddedMySQL()
{
    QString baseDir = QCoreApplication::applicationDirPath() + "/database/mysql";
    QString dataDir = QCoreApplication::applicationDirPath() + "/database/data";
    QString iniFile = baseDir + "/my.ini";
    QString exeFile = baseDir + "/bin/mysqld.exe";

    if (!QFile::exists(exeFile)) {
        qDebug() << "❌ mysqld.exe introuvable:" << exeFile;
        return false;
    }

    QDir().mkpath(dataDir);
    QProcess::execute("taskkill /F /IM mysqld.exe");

    qDebug() << "🚀 Démarrage de MySQL portable...";
    mysqlProcess = new QProcess();
    mysqlProcess->setProcessChannelMode(QProcess::MergedChannels);

    QStringList args;
    args << QString("--defaults-file=%1").arg(iniFile)
         << QString("--datadir=%1").arg(dataDir)
         << "--port=3307"
         << "--console";

    mysqlProcess->start(exeFile, args);

    if (!mysqlProcess->waitForStarted(5000)) {
        qDebug() << "❌ Impossible de démarrer MySQL.";
        return false;
    }

    qDebug() << "✅ Serveur MySQL portable démarré sur le port 3307.";
    QThread::sleep(2);
    return true;
}

static bool stopEmbeddedMySQL()
{
    if (mysqlProcess && mysqlProcess->state() == QProcess::Running) {
        qDebug() << "🛑 Arrêt du serveur MySQL portable...";
        QProcess::execute("taskkill /F /IM mysqld.exe");
        mysqlProcess->kill();
        mysqlProcess->waitForFinished();
        qDebug() << "✅ Serveur MySQL arrêté.";
        return true;
    }
    return false;
}

// 🔹 Fonction d’initialisation automatique de la base
static bool initializeDatabaseIfNeeded()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL", "init_connection");
    db.setHostName("127.0.0.1");
    db.setPort(3307);
    db.setUserName("root");
    db.setPassword("");
    db.setDatabaseName("");

    if (!db.open()) {
        qWarning() << "❌ Impossible de se connecter au serveur MySQL:" << db.lastError().text();
        return false;
    }

    QSqlQuery query(db);
    if (query.exec("SHOW DATABASES LIKE 'econtrol_db';") && query.next()) {
        qDebug() << "✅ Base econtrol_db déjà existante.";
        db.close();
        QSqlDatabase::removeDatabase("init_connection");
        return true;
    }

    qDebug() << "⚙️ Création de la base econtrol_db...";
    if (!query.exec("CREATE DATABASE econtrol_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;")) {
        qWarning() << "❌ Erreur lors de la création de la base:" << query.lastError().text();
        db.close();
        QSqlDatabase::removeDatabase("init_connection");
        return false;
    }

    // Se reconnecter à la nouvelle base
    db.close();
    QSqlDatabase::removeDatabase("init_connection");
    QSqlDatabase db2 = QSqlDatabase::addDatabase("QMYSQL", "init_db");
    db2.setHostName("127.0.0.1");
    db2.setPort(3307);
    db2.setUserName("root");
    db2.setPassword("");
    db2.setDatabaseName("econtrol_db");

    if (!db2.open()) {
        qWarning() << "❌ Impossible d’ouvrir la base econtrol_db:" << db2.lastError().text();
        return false;
    }

    // Charger le script SQL
    QString sqlFilePath = QCoreApplication::applicationDirPath() + "/database/econtrol_db.sql";
    QFile sqlFile(sqlFilePath);
    if (!sqlFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "❌ Impossible de lire le script SQL:" << sqlFilePath;
        return false;
    }

    QTextStream in(&sqlFile);
    QString sqlScript = in.readAll();
    sqlFile.close();

    QStringList commands = sqlScript.split(';', Qt::SkipEmptyParts);
    for (QString command : commands) {
        QString trimmed = command.trimmed();
        if (trimmed.isEmpty() || trimmed.startsWith("--")) continue;

        QSqlQuery execQuery(db2);
        if (!execQuery.exec(trimmed)) {
            qWarning() << "⚠️ Erreur SQL:" << execQuery.lastError().text() << "\nCommande:" << trimmed;
        }
    }

    db2.close();
    QSqlDatabase::removeDatabase("init_db");

    qDebug() << "✅ Base econtrol_db créée et initialisée.";
    return true;
}

static bool my_connection()
{
    if (!startEmbeddedMySQL()) {
        qDebug() << "❌ Impossible de démarrer MySQL portable.";
        return false;
    }

    // Vérifie et crée la base si nécessaire
    initializeDatabaseIfNeeded();

    QSqlDatabase bdd = QSqlDatabase::addDatabase("QMYSQL");
    bdd.setHostName("127.0.0.1");
    bdd.setPort(3307);
    bdd.setUserName("root");
    bdd.setPassword("");
    bdd.setDatabaseName("econtrol_db");

    if (bdd.open()) {
        qDebug() << "✅ Connexion à la base econtrol_db réussie.";
        return true;
    } else {
        qDebug() << "❌ Erreur de connexion:" << bdd.lastError().text();
        return false;
    }
}

#endif // CONNECTION_H
