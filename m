Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632612C470
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455727; cv=none; b=GgFTbvsxSfOPQX7UgYXl0ZDTfW6kYmX4LYRtr+iUIcCGaJs5DpJNF9LSVuqIpTgYfhyHMduCQ9en3Z/sj88ZT/OMn9pA5JmtYAcoL3A+s8B4TZsED6RbfSyyEUfTPxhagXnv8YEiUbQK0/qxo3Wh43zKA9G6wTSLSsgzrDRXBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455727; c=relaxed/simple;
	bh=A/VpehmTL1Oxz9vYinGJ1z/0Up0xgizTMk9jwY4/OxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4IoJEMTFHV6WVkbcm46GoH7w+QSczWGG5wtwnG1ryCHjG9gypbs7txyyntdeOuFdStH4ZWcRgSbWEIeaCMYGfgLh03M9nmzuZkdq+o2ZVyc8M1M3THHnDbac92YXUf6oVInOecu1waOt/t/OVdhLxW/YdlGKAH7/db2rIF/YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPVmvpwl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPVmvpwl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c095b5365eso335000885a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455724; x=1741060524; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UAMp8hSyK7XsiD25GD9QUAAoq1cOP4T1EfIXDur7CUY=;
        b=WPVmvpwl+zBsO3W5vOnMdzlmLlxWbTW8rgEWkIAOsGSNC8D+EDMoN1ZoUxIZs2HMni
         L4d7852CaTAFrNZXda6mUhbFuFK6Vr/EgOaPa6wJB4KCLXZWgj/32LQnTxuyBOYjfeuo
         lONr3aCa86bO8y4fWVi7KcSJtHV1rNSwVSd/mgFCKm0gtRMFUzakiTIMQ8F2FCTekNpO
         od6MY7qC01Epqtm22z6Oim/i0PUAi7BEqAohjwuBpEnp0rOWGOTv9SMYNiD7jNqJiQzz
         +FL9epAgBO6qZLNksQaojhegVuSy66v9Jfh5ROqvAInBpRgx4kuTq7ICMKqRwJz1INEX
         +eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455724; x=1741060524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAMp8hSyK7XsiD25GD9QUAAoq1cOP4T1EfIXDur7CUY=;
        b=nm1s2auZAX4PUm1ydO4jNNVvUVLJkZ0VdgsGoA49XpAxU/0CfxwtxLr1OaOLgsrmLk
         r/gYxOhHYDSpMHMMhVqgGQw0rgrmcRBzaUCislITtaqU6wsmupisjfhBH/DqT+pxAabt
         npPQVYDUvYGeHCvqX17PsR+USO+N2VGDO6qjg5LCXYtu/ReCcWjoAUJaRPVfSlPOwGnP
         cyAdXj3QsMwFljaJsmGTxvlND1wQy7bp6baBDVjE0RDMhohYL0S1ARubB8ri5IXYUBMU
         5U/fqdzQsvgV95OLoDJvtzkdhVq+5175HuZCezlQXFBcvCxmQeRgmInvSkyq1oietg1q
         MX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVRy+SNxU+pjdIQE9DlVH/ZsaF1MSgRn3JWoTu4dfumbtozhxSdLPTaFUSZXlEDj6rsi4YGDjzAylaBoDqeRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzm2kieSOAcKl4Sk8jgzU02yvUrcv1n5fE+HR9SeRKZktSq4kUK
	S7XCzXCZyJeAkTpG3K4ubT1LjVEq5J7AIVQoHMHEPG5++VCAZWhH
X-Gm-Gg: ASbGncswNluFHfGf71v/E7B4swQfRIUF4S16Ajrz1LT2wSfEMzgYPDq3FUV+oZQWsdx
	4o+9ubvoq4byUFshu+SEA10/MIH68U3oQoBLPMo1Lzt3VxvUjsIahOntHztS8Q9Fed+sKzGiSJS
	bw5ckKXOE9/Dk88QcsC+IFnoM9Vr12N6HehWdlygUaVBmSZCktA/tKQioRyv3pX47M8DcWNZvVo
	HYqVKCedGAjPMKMKP+ixKDKewyW94ucbEvxPGfc5msRTLjp6/n0T/gvQgQ7mqjYvuQKfW2dK6Fq
	/mSCkL+Xb0xxnriFh6sfXLD6eS7EOprQfr9XEfUDETxtf7zOJep6boeEaULSlqXPRtJtREZxqXU
	ouk1W2uDUEmZIA/Xn
X-Google-Smtp-Source: AGHT+IGCSWdxbzgQ8ZHPgeeMU41gQqhAFunf7D6fAu+8M1wWlojOk7D1fxQNY2FAngPgnrW6omeP0A==
X-Received: by 2002:a05:620a:29c2:b0:7c0:ae97:7fab with SMTP id af79cd13be357-7c0cef538c3mr1983966285a.39.1740455724319;
        Mon, 24 Feb 2025 19:55:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b09e51dsm5087626d6.66.2025.02.24.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:23 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 159B51200043;
	Mon, 24 Feb 2025 22:55:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 24 Feb 2025 22:55:23 -0500
X-ME-Sender: <xms:Kj-9Z_SrAewRsfeaEzLj-0VdjS1upAUXlXlEviquYKJtqx7odUT6uQ>
    <xme:Kj-9ZwyLGWLnVA1RTGYOyQrpMP-ZCdIQtvcDzlJQC8sdKnHdzUvrZElBgKUENzWHB
    wP6dlX0vzwKagE4Nw>
X-ME-Received: <xmr:Kj-9Z01UPUZuw8yWOca4AEPCR9Ee5h7PoP17icj6LBjIYQzMbhfy8nZasQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeftddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:Kj-9Z_B-ucMSoa_XzCSWQBE03iwZnif9piKx3CkH6nQ-qV41ptQZUg>
    <xmx:Kz-9Z4hwil-tMo715gqBt69ac9L1lqzGElHema55mI02XmNY8ua4kA>
    <xmx:Kz-9Zzq2Uj3JxybyAXRO5qGc_ISBIbfLSRr0VDXE3NX6xBaSrkkqOg>
    <xmx:Kz-9ZzhEBShilDrXcA1_gO5FlqCaDhTkgdMzlM9ymXm-XRMbra8fzA>
    <xmx:Kz-9Z7Qo2UGdWC_6jzIq8pPMLnN9leS4J4-Q6CYnOGodjvUnFNNlgLKU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:22 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH rcu 02/11] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Date: Mon, 24 Feb 2025 19:55:07 -0800
Message-Id: <20250225035516.26443-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225035516.26443-1-boqun.feng@gmail.com>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.

Also, since PREMPT_LAZY implies PREEMPTION, we can reduce the
TASKS_RCU selection criteria from this:

  NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)

to this:

  NEED_TASKS_RCU && PREEMPTION

CC: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutiny.h |  2 +-
 kernel/rcu/Kconfig       |  2 +-
 kernel/rcu/srcutiny.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 1321da803274..31b59b4be2a7 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,7 +64,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
 	preempt_enable();
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185d..e2206f3a070c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 4dcbf8aa80ff..f688bdad293e 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -98,7 +98,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	int newval;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
@@ -120,7 +120,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		preempt_enable();
 		return; /* Already running or nothing to do. */
@@ -138,7 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	preempt_enable();
@@ -159,7 +159,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_running, false);
 	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
 	preempt_enable();
@@ -172,7 +172,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
 		preempt_enable();
@@ -199,7 +199,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
@@ -261,7 +261,7 @@ unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
 	unsigned long ret;
 
-	preempt_disable();  // Needed for PREEMPT_AUTO
+	preempt_disable();  // Needed for PREEMPT_LAZY
 	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
-- 
2.39.5 (Apple Git-154)

