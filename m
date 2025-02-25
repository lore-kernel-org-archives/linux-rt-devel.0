Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF4253331
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455734; cv=none; b=LlbLJ5vU+DVsm8ZE3v68RKaMN3g8w/+vVdo+hQKAbbv8b0DicgsiAUN8v0aJ67oujd3fi+1+a1309ntr+i/JUHqm0vnQrEEQDhxugPzwRyAYxdM9WPCLNyE9svvdBkK8njizdStLU5odzLdurTg59HSzEKAOLkQ/xiUq9GV2P7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455734; c=relaxed/simple;
	bh=1tDISaYeQ3S03meuTtLRl+xFGXAMQ/cviepaRDjCquQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWDd2umhBHjDYXCY4H3IKepyW4LVWCq0IBpU5T0P4K4PwPPR8paXOYWrd2iFoGzuJ3zDeE2b0e66ussySthFQevEygNOOjMupB6JQ0xfX1w+jRmSwKVuyISRL6urD4RYf4VSPNdmaHK5BILKeAn8RSUrQj6VYlVot2pXVXo9ehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQqZ9DDJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQqZ9DDJ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46fd4bf03cbso82720781cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455732; x=1741060532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9YYDq/qQc7Ji7bn3SbKnVlJKz11oqy/6rCNHG+ssGTA=;
        b=BQqZ9DDJ5bxjoZYid20JAGlVKHwNibK0bIAOJ0J5Qch3Nq1MCAaIZ/zem2l9Brxsuj
         XEVA2xVDDhJPr/nqZdEFFuJ71wWMHmiO6c5Q3XRHdQyE1paVVq6Q5YlPkiMAhsdDVfnI
         BdQHnp+5YurGAgImicahnpqH6Q9pcM8+puviTZhdy0qA5aWw+C6jA2ADXnx8KQDkAU29
         4AN7EYVwSek6NM0mH4qLXA4NqLQ7bZgXWHgWrMmoJfXld2goHFb42vqSQ8FxUuc0riLg
         /PcmYfpoJAey8rVT4FSQ/FT2Rcdxj5lsxWhAyTP8AaG7fV1gExi1f9fkqWd5yd7qDe44
         LMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455732; x=1741060532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YYDq/qQc7Ji7bn3SbKnVlJKz11oqy/6rCNHG+ssGTA=;
        b=aj+SLkuwBKIW1ME2810bKndVatT3kATwrj4nd1cdqzFnY9ODcPRUwag9ePZOSRA1nG
         L6rF+J7bvGbYMUmLNMfotUDhD/WoobnZ+M5kSkt3r88DazPUTCa1x1oyz9GtqIsPeNhQ
         PvwZUBYpui5FpFlKAbpZDZal/IHtfauyASn+3hz4B8coRSnW41lp/gcas4xkUcGLYmAy
         0b1U1ohpFE1cfvIvB9q+Isq+EStt7aatsS2CytvUtj9FIu0IaU9VL5YH2vRQAJNLxzDk
         o1PMeX/aAQ4gMB3aspGOCKxSBULyYeYoYOCQ6clZ6hQfQxCe3WmXb9eOUCGG5sk9wwkZ
         +UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbeEB7JZtXHBQuv9NjbCQOtaiohiUY/lBqsDBbNruUxIpW8zatmnPY1lzHQKNrm1a1YhZIrdmdPZODDlYroQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhfyC0UZWQR+Dkshn3ID2Z3A3tXJiNQ53UrqxmxQhFbou87ril
	Rf0GOHv3k4v1XHQwLN6UH4eXKFmzp2b9lfs9UdtfrRo/UNdk5TP0mvE7Cg==
X-Gm-Gg: ASbGnctRNMcNF0wzDh2s/Tt3zS38iEQFk76HGwr+G1gTry8If4UmMtFzz1aaIqL/XyA
	U25xcATD+LpbFUT/kW57ZKnmfuutL9Xpy7SFjbn+NuTSzLvSIGHANZV+cvrwaWRZKrUikU8x/21
	yFq5S5sPbCarf9EkRFb8o9lV/2BhLPtjSQUpa6LhK8+YzJ7G6kchjPr2QqFRuxTSywiRuYssFSM
	QBR/sZ6KkspAGIwYjrBF6MaA/tCN2MBQUdcaNwhJNJ5VZH+Ki+S0i/8J1wgq3aQyp7QA0hwJDml
	dQj4Bm9CDotn8ZgnPIOhQMrVhJrjJeRy4nn0xpARRkVGn5E7FkPu63ZugjSR1pkmU719trglwNO
	X4wJTidBTdpYe4NlV
X-Google-Smtp-Source: AGHT+IHMXuxSGfHeFeWe6ixvXP5jkriSYpqbZd+mVCI6P3K34NPERaJ5lBv6YBRO/9abgXR/Xk5QdA==
X-Received: by 2002:a05:622a:1ba6:b0:471:ffbc:9bf with SMTP id d75a77b69052e-4737725c824mr20978481cf.40.1740455731579;
        Mon, 24 Feb 2025 19:55:31 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a530sm5087501cf.59.2025.02.24.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:31 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 556261200043;
	Mon, 24 Feb 2025 22:55:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Feb 2025 22:55:30 -0500
X-ME-Sender: <xms:Mj-9Zycof1WpQ3Bd_getgu6ynIJYBtY4mu3Nbb11MAvm2n0rl7UIyw>
    <xme:Mj-9Z8M-IcO-nNRghXpL57OLLf_NG2SwXHUkEJfqct_GuDc-QQDIBp1-M28QaQF3S
    7ZQWpjWSGwpDSf8ug>
X-ME-Received: <xmr:Mj-9ZzhDr-B91mGR6b7Ttd3cK9qOzeKKjjkHdU_nD3yg73s5JSfVZJ4ykw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeu
    heelhfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgt
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhr
    gh
X-ME-Proxy: <xmx:Mj-9Z_9ah-0n_cvkXRGP4YU1K_8HR2CUh2p-sLEfTYxmsVAuok3_tQ>
    <xmx:Mj-9Z-ucuv-WmKDRnQSJJrPEx84oTaxigSDkZrrrl9goephMby3kIQ>
    <xmx:Mj-9Z2GO-n4hSbW7C-0IogsqifJcG_3jp43Y5tnK395FkwlfjYAAfg>
    <xmx:Mj-9Z9NWo_517UwERJU0WXFf3CAor2g-0aeTzuR72sFqAqdYyFsQEw>
    <xmx:Mj-9Z7NWwjjtJrwsVZB10y5ItcL4l7M2RMhOLAciBzm_L46clUiY3T3q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:29 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>,
	kernel test robot <oliver.sang@intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH rcu 07/11] rcutorture: Update rcutorture_one_extend_check() for lazy preemption
Date: Mon, 24 Feb 2025 19:55:12 -0800
Message-Id: <20250225035516.26443-8-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture_one_extend_check() function's last check assumes that
if cur_ops->readlock_nesting() returns greater than zero, either the
RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
is, there must be at least one rcu_read_lock() in effect.

This works for preemptible RCU and for non-preemptible RCU running in
a non-preemptible kernel.  But it fails for non-preemptible RCU running
in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
function, which is rcu_torture_readlock_nesting(), will return
the PREEMPT_MASK mask bits from preempt_count().  The result will
be greater than zero if preemption is disabled, including by the
RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.

This commit therefore adjusts this check to take into account the case
fo non-preemptible RCU running in a preemptible kernel.

[boqun: Fix the if condition and add comment]

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..280bff706017 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
 static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
 {
+	int mask;
+
 	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
 		return;
 
@@ -1902,8 +1904,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
 		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
-	WARN_ONCE(cur_ops->readlock_nesting &&
-		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
+
+	/*
+	 * non-preemptible RCU in a preemptible kernel uses "preempt_count() &
+	 * PREEMPT_MASK" as ->readlock_nesting().
+	 */
+	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+
+	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
 		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
 }
 
-- 
2.39.5 (Apple Git-154)

