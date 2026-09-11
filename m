Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC282866
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137508; cv=none; b=sDEqNgZP4kjy5FGsGbEbUwVeyUZPsdsztQv9+A5Gp3VoU0pvZogtudv/FIpIAUXyYLc8KFd3NuY7D+99NvcbOqWlrnYePIfEzbWcFGAXluARhuwLGFRd8Wrwhjvj+1tYbn1+EdwdmD41JZCC8mWaFM0aywdh6O6i5nTva5CbLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137508; c=relaxed/simple;
	bh=G949rd2BksPJPpHrTKqHHeH5/djt9kP0MvWFp7GAx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqLFqb4fPDA8h9gb2OlvhGNJ6y23HpL86IiIOkzFuB04XMNef2J8r9I8m/kHdpE36a8JyfDW5nx9UWLKpacxAVd5lMum5TmrgJxQJXm/OWU0ld3yDex0KnKku6KUJfz/92WjxW3dr11OUiKMDga+PVe1XZCdDgLYdnnToEE3gTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlydMHuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5LkwNFn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlydMHuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5LkwNFn"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789137502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fnhCFqimC/U/Uavu1hoREyaaaFUjMv/5s5k7FC9gQA=;
	b=AlydMHujNCfNMpCWYFVDLLwXRO9q9caQxsvHmhIMz/2xx3fUuRjlA9JswlzZpa853WlzEF
	emkRXQnJuRXCiES5757NMqIJHDHYm50Yq4XCjGpaOzOG/aTjUPIYxlr2bAPZRKgRIVHzkg
	dlZZwMHtVWunF9MRofvC/R7S3+GzDmXGfvtZdMvsvk7Aeos6BlP8Ee3UMvnYNGJ2ZZa80r
	x3Hk0UM12glMsu/DNJSMbd8MLl6H2jXRGDcbpdluDqP5q3sSXUbSIgQdxjIYiXGB5e8nTI
	C/0NURe962tExwSKCteXag8wgvnkkBWkhL2Usmu67vY37Xy7Hhv+kJ9Naum23w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789137502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fnhCFqimC/U/Uavu1hoREyaaaFUjMv/5s5k7FC9gQA=;
	b=Y5LkwNFnKn7PUVSkOB9tggzIn1BJFBkw3id2mk4JXcYQ5pQTIUSRje+uoReR8E3hmZA0Pz
	COUuYtqrcdcLK6BA==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/3] smpboot: Don't park the thread if work is pending
Date: Fri, 11 Sep 2026 16:38:14 +0200
Message-ID: <20260911143815.997254-4-bigeasy@linutronix.de>
In-Reply-To: <20260911143815.997254-1-bigeasy@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once a smpboot thread gets work assigned it receives a wake up. If the
thread had no chance to run and receives a parking requesst during a
CPU-hotplug event then it is parked without running the callback first.
As a result the enqueued work remains stuck until the CPU gets back
online.

There is nothing wrong with invoking the thread function first and
parking in the following iteration. This would ensure that the callbacks
are processed before the shutdown.

Honor the park request once thread function does not need to run.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smpboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 4503b60ce9bd2..3f60e8c6dd301 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -103,6 +103,7 @@ static int smpboot_thread_fn(void *data)
 {
 	struct smpboot_thread_data *td =3D data;
 	struct smp_hotplug_thread *ht =3D td->ht;
+	bool should_run;
=20
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -117,7 +118,8 @@ static int smpboot_thread_fn(void *data)
 			return 0;
 		}
=20
-		if (kthread_should_park()) {
+		should_run =3D td->status =3D=3D HP_THREAD_ACTIVE && ht->thread_should_r=
un(td->cpu);
+		if (kthread_should_park() && !should_run) {
 			__set_current_state(TASK_RUNNING);
 			preempt_enable();
 			if (ht->park && td->status =3D=3D HP_THREAD_ACTIVE) {
@@ -151,7 +153,7 @@ static int smpboot_thread_fn(void *data)
 			continue;
 		}
=20
-		if (!ht->thread_should_run(td->cpu)) {
+		if (!should_run) {
 			preempt_enable_no_resched();
 			schedule();
 		} else {
--=20
2.55.0

