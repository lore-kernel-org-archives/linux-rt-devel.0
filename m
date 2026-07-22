Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF33BE17D
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712712; cv=none; b=uf2elJFZufTCO/F0uvpOV947fF6M/qjvDyIdX1OWhN/tpBYNN9u6xalMfye7EdYKjg+pavcTlm2t8erGKkjThHmrmzHxbz8NB6FvGfVz/xHSYqo0y+Io/fR3Q+VxzWBuUVKtk4Fv7MQH1V2i0xRrO/VKnResEo89E3SrwLx6G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712712; c=relaxed/simple;
	bh=FhNNAOuZdbJjmOjhZOQnVJE10pAdiK+At8SLKxyp32o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWb5cwz6VVLPBoFQbuTyc7otyBfB7neQEKt2nS3tYy5L5Au7N2F2ytzV1ufue7ZK3T7ZuLS2+xxKLXeRwucNqUiEGW7BtbjnepvXlUDQv/OzM9yVmkaNwqCeLYeLlImMo0+hbq28dEEdBxYrvVcd/k/w3X25B481Aax9ljlwXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ybsVNpU+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OnVC+z+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ybsVNpU+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OnVC+z+p"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784712705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//hU/yOiw5sOjJs/SSTadDB+pEcdesRZupzhebNM3us=;
	b=ybsVNpU+ZoCtnhiZU3u3yLBWmRcyxVvyFp6IFA+iXO2pyMfg7tsW15OcGH2Us8NmUDzp6F
	TXX+W/LwUosD2rK66rn16Vd3vxQPC6OnpXVGj6HdmmLftwFpSNQac3ie07gOfaWkjMeMRI
	nXtRQrk4T7jdj7f6Nbg9p5CPNk0mga23oKhMBdY53eOxsUj2wF8xODlp46dzNy9nWRuzAk
	rweqF/pmPf0+tgctATiZjmyaxgep14/dFunLJFhe/UrDY2qH3C1suV1s0fU6wSsvaKBl+Z
	WHiph0Rr9qrJbqIpHLZdVd92VkscNx/Lgg6l7V475/a/EQG5PmjKXuh7MHjyxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784712705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//hU/yOiw5sOjJs/SSTadDB+pEcdesRZupzhebNM3us=;
	b=OnVC+z+pMuZM1WrDq3f24Wv+SF661LRqpcTJ7fNu1ojx3C/WcgiOPO0llcDVQVKqe6W0P7
	IMDUufmHjfWAVPBg==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collector at task exit
Date: Wed, 22 Jul 2026 11:31:34 +0200
Message-ID: <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
In-Reply-To: <cover.1784712370.git.namcao@linutronix.de>
References: <cover.1784712370.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a task exits while still having dead cyclic reference AF_UNIX sockets,
those sockets stay behind indefinitely until the garbage collector gets
scheduled by an unrelated reason. This can be observed with the program
below.

Resolve this issue by scheduling the garbage collector during task exit,
after the task's file descriptors have been closed.

 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/wait.h>

 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>

static int send_fd(int unix_fd, int fd)
{
        struct msghdr msgh;
        struct cmsghdr *cmsg;
        char buf[CMSG_SPACE(sizeof(fd))];

        memset(&msgh, 0, sizeof(msgh));

        memset(buf, 0, sizeof(buf));
        msgh.msg_control =3D buf;
        msgh.msg_controllen =3D sizeof(buf);

        cmsg =3D CMSG_FIRSTHDR(&msgh);
        cmsg->cmsg_len =3D CMSG_LEN(sizeof(fd));
        cmsg->cmsg_level =3D SOL_SOCKET;
        cmsg->cmsg_type =3D SCM_RIGHTS;

        msgh.msg_controllen =3D cmsg->cmsg_len;

        memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
        return sendmsg(unix_fd, &msgh, 0);
}

int main(int argc, char *argv[])
{
	int fd[2];
	int i;

	for (int n =3D 0; n < 100; ++n) {
		if (socketpair(PF_UNIX, SOCK_SEQPACKET, 0, fd) =3D=3D -1)
			goto out_error;

		for (i =3D 0; i < 100; ++i) {
			if (send_fd(fd[0], fd[0]) =3D=3D -1)
				goto out_error;

			if (send_fd(fd[1], fd[1]) =3D=3D -1)
				goto out_error;
		}
	}

	return 0;

out_error:
	fprintf(stderr, "error: %s\n", strerror(errno));
}

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/net/af_unix.h | 5 +++++
 kernel/exit.c         | 7 +++++++
 net/unix/af_unix.h    | 1 -
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 34f53dde65ce..686f6f1d1c21 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,11 +14,16 @@
=20
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
+void unix_schedule_gc(struct user_struct *user);
 #else
 static inline struct unix_sock *unix_get_socket(struct file *filp)
 {
 	return NULL;
 }
+
+static inline void unix_schedule_gc(struct user_struct *user)
+{
+}
 #endif
=20
 struct unix_address {
diff --git a/kernel/exit.c b/kernel/exit.c
index 2c0b1c02920f..593ac4b0105f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/unwind_deferred.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <net/af_unix.h>
=20
 #include <uapi/linux/wait.h>
=20
@@ -1009,6 +1010,12 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
=20
+	/*
+	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
+	 * the task's AF_UNIX sockets have all been closed.
+	 */
+	unix_schedule_gc(NULL);
+
 	sched_autogroup_exit_task(tsk);
 	cgroup_task_exit(tsk);
=20
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 8119dbeef3a3..fc4c59893124 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -30,7 +30,6 @@ void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_peek_fpl(struct scm_fp_list *fpl);
-void unix_schedule_gc(struct user_struct *user);
=20
 /* SOCK_DIAG */
 long unix_inq_len(struct sock *sk);
--=20
2.47.3

