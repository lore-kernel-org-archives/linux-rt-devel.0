Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3E24EF7E
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455731; cv=none; b=jZBY1lmsgYkTnyRZdD4ybPkrMDmMbe/6F8bR14AhB+3Km4Rwe27Fs96XCjamabRdI9vgOtOdECCBFHixU9Bch07F1JzVtgBp7sBqpA5bIVyFPZj0D/g4sOobMF7k1zneNZf6dfe+xXLjCB9Q18EsN5+5DzMdo2y7MbMX2VDpDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455731; c=relaxed/simple;
	bh=+xWSr+nkJ64yuyk2bAtOMGffsUZkkwlgArf+svUx41k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y27l1Ff6E9de04PTY2UmpUV8TerX6voY5cuQrRO9yFYApWkWAAtVz98ssk2c0I/Xhvw9iQWEj9meHN16bA4EP7OAp2IyxLdAzMVrGws28lo7fbmBIHRvttq/9nhBaZres41Z0iA6Yo2G3J17QqJqRPdiKEY5FVAmNGAUtlKmKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC7FcPwq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC7FcPwq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0b24cc566so429148885a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455728; x=1741060528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdozoCwQSzFwrrBbMNFpZ8ApNw9FrREQJIW7RONrtaw=;
        b=ZC7FcPwqlS8w4eaFZq5rY6lCtbkolP6IrjsjqPuDrEYd6xoxJV98pyRuPmwOPFPvZV
         ABlV95V9T7bmdPjRLaPFPWRuK36eEYK4YYvkzuIeghjQas3GTYnWVcubuDC7f+eVIYCO
         rOrZaOAT0NdVdfMuSNmtL8toFm5On2rsP1Y3A3IdnEgsbjI9IFFA92AYAnJ7G79h/Wpu
         pBelfb2+S/qveoGt8OoMx/J5v7N+uHvfr9AFH/QgiA8QspknwADrUfhSM9MEAR4MJhhO
         9yDLXGDaRukZQQPtU2C1t35vRDxBXNQnBLn5ozzloBve2GZHo120BYAjEbWndrkasBpl
         a+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455728; x=1741060528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdozoCwQSzFwrrBbMNFpZ8ApNw9FrREQJIW7RONrtaw=;
        b=vVm+mRI4ovym0wab3PAf58lmloPwbfbLoDNECsPOBoZIUJhPIlpAzJv6fj2bOY6Lls
         qeyD/j4+wZmMXmvz/o1b5y7boL/tCM38xupcmOO5VQIZhNOkU3sQLno4UmJalbmCqnPG
         Z+pfsEJje1ENEBJ3P3q7TzcNW73pryAvaE9aveW6mhL40v1T0Gh1y6UM3dK5/XRiDwTv
         y6vzGDVj93rEFhUwttFwGJzlczLbctDp/nRAAP7q558sXd69DAXXle1zRTXPbHb4tUda
         X9WVoS9FmH3P412c3vyEcvZUvcP6BwdKuhgnlOSavRnO4Ld/GLZuZjKMUOWneKZ3+laA
         5UmA==
X-Forwarded-Encrypted: i=1; AJvYcCVsYU5w4jgJb9lAcgOjKAgajz020+E9k23EeQ+VSFZRTObTmt8nOwCzev0EJ8byKqzyuuPuL4l/iZ/bMqTKNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvs3hnSRoyVsa4vnU4rEbWikFFTV3chVB5wbY7OMpmUlpgqbMG
	ujJ9cOsNcBSgpJsLHl3aXLkbeWNjmduNyRlGAHaik/RPDT8E1Mgk
X-Gm-Gg: ASbGnctGtPCfrTGdtqeof0zkfnbVWtjafk9xaBa1iFq9aKI3A4NZP25geA1I/2aQYwf
	zh1FD8Mwe6WM73y7DiyWh92cQ3BN3aDxuYA81QCIg4hCG+L0F6gDZ4rrAkr3Ge/6/re/dt7PBnv
	/4P/K38QC4lKbfef80EfKskBmVvZa6nWDn/mVAKTTu7P9frfDUNvV68vwCmValNU+GrzOBuGlya
	JvGKtndv2Dmg0U3aT30PZ2/jutahCow6WdJ4u96XXCbzbJi1KPM2+DPjJmDmVwf1n664h+c+5n7
	v6PSau0QaIau0DaPRzfste1eIglWEQN8yYoSxLqekqWAX/fJj1bPD7dr8D7WqUTjM1p5NSDyznO
	c+mIFhWMC4xQAgx0q
X-Google-Smtp-Source: AGHT+IFTwNMKfPJKSVdkAd2wzvyYLeX43jvuaeqy4yYDCxwRmbSxY2gEiMA5fWXJHX7/6sVrC3Ghhw==
X-Received: by 2002:a05:620a:4606:b0:7c0:7d34:6a7b with SMTP id af79cd13be357-7c0ceefe59cmr2223508885a.19.1740455728549;
        Mon, 24 Feb 2025 19:55:28 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2c241dsm60007785a.58.2025.02.24.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:28 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6B68B1200043;
	Mon, 24 Feb 2025 22:55:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 22:55:27 -0500
X-ME-Sender: <xms:Lz-9Z1ntkdjB-ig_XPh83pP8VtIJZhM_mp8c0GTmZf2It08_6g-6sA>
    <xme:Lz-9Zw0hYpVlIsjQxPH3BZYQlvWB_1kiTLBxD0_SX_g_ZmfsORfZm1C9VTiUGfB0F
    jbFKUIE2EFWId7elQ>
X-ME-Received: <xmr:Lz-9Z7oY1nnwz51wobKv6Et71hWNkyMzylWcCfs3Y4KLc9hAYCuncQ0RZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
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
X-ME-Proxy: <xmx:Lz-9Z1kPu5YaqLrnWSfvXJIvMKwBFrnwnsTWZI4XCBXDTZNcY-u_VA>
    <xmx:Lz-9Zz1Dv81tx_ttsaFyq1QJe-8B6AzkGJ8g3EqsAvS-JcfA2F-Vcw>
    <xmx:Lz-9Z0sL-9OBc9_Ac-vlNfMkOYHmC4t3lcyi5OQR0_6sXuDkYzPATA>
    <xmx:Lz-9Z3XCyrPSaYPqtSpnQnKeGfxCMWMowDC1ynszNxCKmNkUo_7McA>
    <xmx:Lz-9Z622lnr25oL4SH-gxvSuf-mFwlA67Gi8WGXBtmfpqKpSiEWRqwHg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:26 -0500 (EST)
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
Subject: [PATCH rcu 05/11] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 24 Feb 2025 19:55:10 -0800
Message-Id: <20250225035516.26443-6-boqun.feng@gmail.com>
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

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a
read-side critical section or not.

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
does not provide quiescent states via rcu_all_qs().
(PREEMPT_RCU=y provides this information via rcu_read_unlock() and
its nesting counter.)

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9573408a9800..3c0bbbbb686f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -984,13 +984,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.39.5 (Apple Git-154)

