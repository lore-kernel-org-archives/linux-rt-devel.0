Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8403AB29A
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269649; cv=none; b=g/pem9Ky97eJBWZK+klOTXJMG6GlvmBrPIZHeIAn9lzAlQqf2kwUyVjfkLBEf4oe/UMdzRyZu7QpBb/bLKCH0rqUTmj70HP1SjdcQDKKiKCgU43i/CDpK4XkaKtHtdSUpClzaD0JPnRbN2G4NsaQUPe0H/82OxdcRgnZJstXBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269649; c=relaxed/simple;
	bh=DLVM2Wzs1hkPFwJR2tdyFF8jpGHl4pQL+T7gotY/r/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOxMG58QHRvdSdlH51F+WMXJMOMN8LhxyS0xgq3DylrmKveGEfXNZ2QvNw13YG7Fd3X5wpN61ZsJAHTEfFPXwTqw7K14DEsOgfR0rovbNQl3Ztrr+U7LntY6WlUWKc+0Y/77QAegpmzq6i+5jgnjdpdzH366BmWCgtByiu0Ux2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnkX7ep5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMoWmDbu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnkX7ep5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMoWmDbu"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784269646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRiOhW5HZb5V271O3MBx6AO5JteGsje3lF8XlUmLt3c=;
	b=jnkX7ep5yVEzA017UKC8IPbWUuQs3AWCHo+3Qw76bGFVLBwUBHyqXNDiZJ/zmksb7cJN6y
	22Z3TXNd3mJRemjoBEoe4Xb2nWNloetEzd9e4LnvrGrsb44bi7Um19gByDTW1nJgJYPpeY
	2QAEkUraiPPrXtw+IchUXIhGopBKDYxtF5bKTOqoKF5zeBtmE8UnnTz+3/xMyS1blxn9Dc
	GfCgYfY6IAOTnQ6V4/bb1H8WcQMxLyKyseL0GdvLB08jzjRtAjHshHbLFHMWWS8M+I/ipi
	Z5x9ZZToZBWkaD/BmwYwzE24qxa/xvA2rClJhu/Q5iYuDFDJD0wd+Q3HBydViw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784269646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRiOhW5HZb5V271O3MBx6AO5JteGsje3lF8XlUmLt3c=;
	b=gMoWmDbukUsZTkbVJbBP9m/icqVx7cun90d/EF1Cfue8/rHUJeZvV/6tqUargiBv/j4ljR
	EbnbZjhA+Zw7oPAg==
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
Subject: [PATCH net-next v2 3/3] af_unix: Clean up unix_schedule_gc()
Date: Fri, 17 Jul 2026 08:27:17 +0200
Message-ID: <548b1b624b13fc2582b1236a2c656e4261eb2525.1784268931.git.namcao@linutronix.de>
In-Reply-To: <cover.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

unix_schedule_gc() is only called with NULL as an argument.

Simplify by deleting the parameter.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/net/af_unix.h |  4 ++--
 kernel/exit.c         |  2 +-
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 14 +-------------
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 686f6f1d1c21..1dfdc0720052 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,14 +14,14 @@
=20
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
-void unix_schedule_gc(struct user_struct *user);
+void unix_schedule_gc(void);
 #else
 static inline struct unix_sock *unix_get_socket(struct file *filp)
 {
 	return NULL;
 }
=20
-static inline void unix_schedule_gc(struct user_struct *user)
+static inline void unix_schedule_gc(void)
 {
 }
 #endif
diff --git a/kernel/exit.c b/kernel/exit.c
index ba9404844523..764a911f111e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1003,7 +1003,7 @@ void __noreturn do_exit(long code)
 	exit_sem(tsk);
 	exit_shm(tsk);
 	exit_files(tsk);
-	unix_schedule_gc(NULL); /* Must be after exit_files() */
+	unix_schedule_gc(); /* Must be after exit_files() */
 	exit_fs(tsk);
 	if (group_dead)
 		disassociate_ctty(1);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..759db734a866 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,7 +733,7 @@ static void unix_release_sock(struct sock *sk, int embr=
ion)
=20
 	/* ---- Socket is dead now and most probably destroyed ---- */
=20
-	unix_schedule_gc(NULL);
+	unix_schedule_gc();
 }
=20
 struct unix_peercred {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index f180c59b3da9..d46aeb9d2051 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -635,23 +635,11 @@ static void unix_gc(struct work_struct *work)
=20
 static DECLARE_WORK(unix_gc_work, unix_gc);
=20
-#define UNIX_INFLIGHT_SANE_USER		(SCM_MAX_FD * 8)
-
-void unix_schedule_gc(struct user_struct *user)
+void unix_schedule_gc(void)
 {
 	if (READ_ONCE(unix_graph_state) =3D=3D UNIX_GRAPH_NOT_CYCLIC)
 		return;
=20
-	/* Penalise users who want to send AF_UNIX sockets
-	 * but whose sockets have not been received yet.
-	 */
-	if (user &&
-	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
-		return;
-
 	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-
-	if (user && READ_ONCE(unix_graph_cyclic_sccs))
-		flush_work(&unix_gc_work);
 }
--=20
2.47.3

