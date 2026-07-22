Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5983BB678
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712712; cv=none; b=SxyNaDZkJV/syc5Nr95zj4bGyF56AiLoBVlC83uFaPCA8G8u5YAcD2QWnKsQ1KINv7ua+gmuLgkEPibIp2l8Z950XYtMMlslfRe/IYt8kO4mt9NfAwi9WO5+QtH6FBCGL1uvuS0v/mOSknSOdMPjRDYDYHCnCu3N61DzYHjSH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712712; c=relaxed/simple;
	bh=54clxR4Y7Ire9atdRLbLLlVF0DNCoHJ1sUhFNluydbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdwalPuNu6mtXHMuYG5p6dhKJizep4yw0j/MvmPOr3LHnMPq0Pk7oQL9nfLPhowCcWL0CAhg+IbrjpyDpJsUgUXb0pUGAGxDkg21WttUVY7k00KiLjvkWeRZ/V6GPe5sG5CdoJjdb0oH159ilJ8flh0klouwyJT2xAHKrHyE4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uT9f0eZz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FkJoMrqk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uT9f0eZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FkJoMrqk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784712706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7ryrZMK1toqK/Q5T/ObTQWuQFC1gEfa4g92VkA5uao=;
	b=uT9f0eZzjL6eQgIbud9fkZyp1NxeeZxOAZHzjXU2jERaKJYLCyMJANc7gJWmUWn27f4Xfb
	x149d0q0ts0ywPcD34z5RfjhiXOkedMxl5eiEInr8uog1n3QWz+qppWVJ+Bb5Ke8ajAfE+
	hq4k3RxfXyCYnaEFurzNH6x7UngtohQWguIzikp1OjnVLsnRfmVK/MvHgrb0A89sUziYJ5
	3SjAapwnsqns0I+YyNi51F3XirUUTLn70NgyZj34BO+1fBTfAIuhgqQ7oDodxGhT3XvexE
	o7FoyvcH0miL+2OdwsbQg3rNju8HnQ+5o5jRkHZ5/s9Pjx+PnY2HSAhjOLfhpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784712706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7ryrZMK1toqK/Q5T/ObTQWuQFC1gEfa4g92VkA5uao=;
	b=FkJoMrqk7CrAyGOS91611ag9HbK53oBw3wZ7lZWdinnQIgg1H6WdbV4wtNqpsdI3pv/2hg
	dlTSprdNrMw7O/BQ==
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
Subject: [PATCH net-next v3 3/3] af_unix: Clean up unix_schedule_gc()
Date: Wed, 22 Jul 2026 11:31:36 +0200
Message-ID: <79c2a0d700639a430bacea5dd9581caebcd54b08.1784712370.git.namcao@linutronix.de>
In-Reply-To: <cover.1784712370.git.namcao@linutronix.de>
References: <cover.1784712370.git.namcao@linutronix.de>
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
index 593ac4b0105f..50c5eff07bd6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1014,7 +1014,7 @@ void __noreturn do_exit(long code)
 	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
 	 * the task's AF_UNIX sockets have all been closed.
 	 */
-	unix_schedule_gc(NULL);
+	unix_schedule_gc();
=20
 	sched_autogroup_exit_task(tsk);
 	cgroup_task_exit(tsk);
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

