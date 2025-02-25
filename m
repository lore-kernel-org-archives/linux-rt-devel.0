Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F923373B
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455730; cv=none; b=ZyKNw525/WbC2G4liBJOGgT7HDr4Hq2Z7fsfkrFc83JsJZJk/uyD/rdwr6MAwC2gDiW6f9/fmAX/kzGbzHWnenhUHY+Kw0zbBMHhfgmUdv4nnp1Jk2h7PVdCrqdm4izYsDXVgX6pOIIXX0vqBFcX63esekIT954ETnRdlGaqn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455730; c=relaxed/simple;
	bh=N77KqbFVCj3RUrUBBHfg6qA4TgoamCkJ9sF4ME/N0iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBd0GlZcAehQX7koZ2Gyk2Xt/VnikOVx9z7Z9eYNVS7ZHOTvwd1fcf1dZdIFjfnxFcHABCk3rvhBBjFi+QbErt7FxEZBVFlXt/uIsg7rBjGaUGUpQA0oF9FYHFktaKa6MvBdP+9fryrHVReh2daaNQmybk4EhZrHzeePTzvWKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbIpGG2k; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbIpGG2k"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c081915cf3so643399485a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455727; x=1741060527; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bZjSIhc7HiilOm6x/1wfoYX7rNiE79eoPzAm1Y0WKw=;
        b=ZbIpGG2k26rS6F2RpDeLGXAxikumctgKfymOtBJfA42iCFxqNRvspcwqbdQ+VydqRV
         5/4BvFmZd4Mf9Gff3zQnm6OB61I3HtMTM0AidY21ixJiD2arjyOQTi2JgXF3zsCF9Mpy
         CD/ZWtV7UnvJ7NucGc2yW7DKlZW+6C9TEiRhqjoU61cpxtQ7lP40cNqu/iumYdsMloi4
         07chhMunXPgpSeBXmemdHrEV5Y5wl7OPJTva1P6CQ3D9TCEP1ng10qzaqmcODytHqpia
         wxgKZ6ZjoZdZEmz5kus/pplSnlTcbals+tUB510WChF713IwAMCliRLn//von/c3ZhDk
         3bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455727; x=1741060527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bZjSIhc7HiilOm6x/1wfoYX7rNiE79eoPzAm1Y0WKw=;
        b=beaEeuMvhHgikwvB4qFUvLTXTUgxnoyFPrMNiQ6NaOawWrEmtqy2puztjhwqvTbyJz
         h/n2xMX7zmowirMhATb9Hb3OnKDodTW/Dd2FmJCNskDuW0hMbPic/D9qbRIIcmatSOKN
         XY6PknZknxu/Fu9GcDZLfxfy/39GnRCTX+qe3gswpVIzo5JDY64t+EHWsRIDlBMlClpa
         /5S78eTQyu4mbkfD/NMxOMm6CLHRzDv9QoDhWGP42HH8LPEep2F1W36qGkTKNhBdt8op
         NHRyZR92Q8owHhIUUMBIgwKXblCogg2fmlnW2/qsRpNRcgM1cumT02PfDT+kGkDXwspj
         hOtw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBK9v0r7QE9Hr1uWuZOxGDY3PfbRvQl21G8IFhIFtWCxOh968Mj1wqWgqE3D+8ZZPvU6b7zh7jyM0HLSq2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/+SAijU5PBhXExjDKrWJVpk8rHfroubAhhnps2yXW9DK24oX7
	ZjX7aMTnIylggGROa254S0iNu3kwYjC+1Vgj8+cPp6gTkSBiTNuj
X-Gm-Gg: ASbGncuP91RXW//MbUh/2qb5sqNFSO6uBHo0Cg4z5YoNVYPik73yhewv00PnwDEnohi
	3Ng2AJiSB15HjnM3I/dS740u+kzsMktYrcWNIsreCoh77JJrX8YjSm84060Z7/T1tgDkhaZG3mb
	eCv+M9WK7IrX089u7q9K0EzZAlxSzfF8+ZyOEC9y9bzLE0+rS036XrEzEQIgP+92uM00DiQ9eKV
	NCS1wX5w+jjMRCTq6lvdqpFAgnFVNgpH3PyaY7Pfyr2pOagq6yvMUWLE93jXV1aS2USo5H/lmOD
	I10OAulhneVAC8S8SodMgBzp9UlU1tj3Pn5GknSeIneAuhfdevA0fBkhXvt4NwD37Tx/u4XBeu+
	Uw3AK0HV4Q2+SNJ5o
X-Google-Smtp-Source: AGHT+IEC0C0d+DYM8KdIaUvUgJgks+JgO4LiPSAwNKNuUQIS0gx2Q8fQIw/0qV9UDTxtFURTT38lEg==
X-Received: by 2002:a05:620a:f02:b0:7c0:a389:f26f with SMTP id af79cd13be357-7c23c047145mr175846085a.56.1740455727170;
        Mon, 24 Feb 2025 19:55:27 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2992ffsm60738785a.7.2025.02.24.19.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:26 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0B7B1200043;
	Mon, 24 Feb 2025 22:55:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 22:55:25 -0500
X-ME-Sender: <xms:LT-9Z94wqxXEYd4aQd8FQQBiH3TCBbiDYF-MPjfU6ZXFbLuSQPPPYw>
    <xme:LT-9Z65eaeBmrbM5QPhBbQ-Wi8wJ5pgHWJgSomr214ztzKZ2Inhfo6Lj92C987FnF
    jv58jRB_fXQDmue-w>
X-ME-Received: <xmr:LT-9Z0f8tVthd4rh6FLd-k3bZEpE3Nwk3fB-8YMTfHh8meFFWihfY9WQEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:LT-9Z2Kge_WH8db9hxIRgKx0JEF9dZhmCPkZT2LPYp1XKLI2x5uTlQ>
    <xmx:LT-9ZxIaV6oovYWBbGLhe0Pjj4lNrQNGl4JwLaZaAbC5gFu-W7M7aA>
    <xmx:LT-9Z_zhAO4j5QbU50oKFaHgHOi5YeootZcSw0g4TG-OYx9-3nDKAg>
    <xmx:LT-9Z9IxVnDpg55DtbFw2prqduNbfmznnAjDG-IRQJPJ47Kat1Cw7Q>
    <xmx:LT-9Z0avvlfckIdmAmRwyrnZyynz_10N1ggMfdUkeDhgCF8GHfoLfMfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:25 -0500 (EST)
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
Subject: [PATCH rcu 04/11] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Mon, 24 Feb 2025 19:55:09 -0800
Message-Id: <20250225035516.26443-5-boqun.feng@gmail.com>
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

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..257e9ae34414 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3600152b858e..9573408a9800 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -833,8 +833,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.39.5 (Apple Git-154)

