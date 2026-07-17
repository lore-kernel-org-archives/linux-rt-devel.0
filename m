Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540933A9DA4
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269648; cv=none; b=ZgVlZuRBgmADHxFh2Iek9zM1ceD6d87blF8ZANDSpk5TAJWlQIdc/pekRqPWTuZ9Y1GhP2Xc+NgRdcKmCSQ30htzPRRZo0QmX7MoUlP0FFwcXAwh7zKTez7rm0vyhI85y9bnks3AS+jygxwzGdTE4/ku0yishpKsRgBlK+HzUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269648; c=relaxed/simple;
	bh=hrv5JrU8S6tafr5Jwa2ipc5JHUlNoubZwNJBL4oXpbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFfmUEMuMsqs/M+IPSTkYFc/CIIXMt2BekeVTFtQ15RkeysNJhYjXaWRHSagrzou7x6VccAzgngkfBRkGVGKmTVjeMAf28ll7hCH1cgbuwD104qG12d08uiVu9VT7civ3ZawkqChrctNYdGb0W7ks1JwNzhkqNA7uGBsmOpjQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqxGcp82; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wets7NtC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqxGcp82";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wets7NtC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784269645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ+2OGSU7Jn4oAIKoCuhgeqrheHZA7Ez/5R9ijduTOA=;
	b=bqxGcp822S3x1FKhoftdgjah3JjaSpwdx+xjM0JcXWSUh7S1cvYoJ5utgOCh2wuDfASICi
	8EnzpNlN5FmazgVKsdfCGbC/kfzUn5NGX2kUqPdk6y6UOeaNetG5ACGgavxxDCyYJHl3PN
	EiZZJk8/D9Xs7uwihfklmRBu+zkexrHDbBvd+tYsD4f6Edouf0KX4dqpV2M7xKG3ZQZb55
	t5Axn21qv1kxPZzd/vgR8GcYpr3XuKj+d+ea8lf9574QSnD2MIbro5C+QV9+yUVNOMOvO/
	eu8Fb07ffDnLzX/JKEK5r2+hx2aaqDZCP7/yTgqeA0NrUNUm07Hmi7UqSVQeJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784269645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ+2OGSU7Jn4oAIKoCuhgeqrheHZA7Ez/5R9ijduTOA=;
	b=wets7NtCC3quSaZ/5bjqr2N4/GiY8sRE7rNGaRSBzpDXOx8tO8ls/WlkQM+f4rLnoDAQeL
	LfCPoLEx+TqRXCDA==
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
Subject: [PATCH net-next v2 1/3] af_unix: Schedule the garbage collector at task exit
Date: Fri, 17 Jul 2026 08:27:15 +0200
Message-ID: <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
In-Reply-To: <cover.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
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
 kernel/exit.c         | 2 ++
 net/unix/af_unix.h    | 1 -
 3 files changed, 7 insertions(+), 1 deletion(-)

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
index 2c0b1c02920f..ba9404844523 100644
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
@@ -1002,6 +1003,7 @@ void __noreturn do_exit(long code)
 	exit_sem(tsk);
 	exit_shm(tsk);
 	exit_files(tsk);
+	unix_schedule_gc(NULL); /* Must be after exit_files() */
 	exit_fs(tsk);
 	if (group_dead)
 		disassociate_ctty(1);
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

