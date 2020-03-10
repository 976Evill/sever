import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
with open("C:\\test\iplist.txt") as f:
    sp = f.read().splitlines()
print(sp)
for line in sp:
    try:
        ssh.connect(line, username="ukm5", password="xxxxxx")
    except paramiko.ssh_exception.NoValidConnectionsError:
        print('something wrong')
    else:
        ftp = ssh.open_sftp()
        ftp.chdir("/home/ukm5/")
        ftp.put("spam2.txt", "/home/ukm5/test11/spam2.txt")
        ftp.close()
        ssh.close()
        print('success    ', line)
