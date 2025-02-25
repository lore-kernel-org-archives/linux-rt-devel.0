Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A76253F30
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455735; cv=none; b=ph1xS1gAkCZzPWZobEBaG6ivXyhKPem0WOYamm/HIfjIjrHrg8wo/svuMlB3ddEpV2zWAs09xcEEIuVS0J7VZkLCAFzVB5OCandosL+ANocCA7MyAoldOTvNZPfuJ/thIH6EeGYmK8ilw4o3J424b0fCx6dhrKU0bNatVb8xbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455735; c=relaxed/simple;
	bh=lypcfpF4/N47ol4CwHDwwB0rg0jxZ07VELUbrb87mhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCNEIc5HQbzkBbwZxdUZv8Bb742hGvjvKx6mSW8gxav5Oq3C4T7oO8cMm92zzVFifw3Ykk7jKjVKRwSTx1FC6xVaq4l44oqvZAWSyOx9hXGRHwil0SGzANA90dUhY6CrZxyuy8eo7Ah/2PGgiIYfB5YejSAIuq/HWw1ELbgyuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWHwpToM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWHwpToM"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471f16f4b73so46972291cf.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455733; x=1741060533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h419Jx9H2aghJLfc8GQxEdkY5w4iKmNadb4INpgW1eA=;
        b=IWHwpToMSQGje0eCMAhAS55UYxskrKsyb2NJ5s5lfyme430RcDMAG5dpCvpM7WWymr
         /liJhtSK7B2Bl8oyO1HjnQ44LoLIKaQaeW2yrRhzLdRoBBvxCqUKx5a1rwGJcjYfCtYX
         DEk3KS0/PV82UC0y4kLx2LucB0wwRSnRkytP1N3dsJEzXcTWlgD4+qe/cscy986vk389
         jGNxKl2T4xssx4ImmFPci9PHg39T19bzn2FdEcYtanNR6PxDolUKP+aF/X2vyxUB+cKd
         PcNTKENtZyFSIq2cH47EulNTNkRNWVYr9oss8HBgqapIOTdYeFpOnwXdnHPO1A3vDb9t
         qdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455733; x=1741060533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h419Jx9H2aghJLfc8GQxEdkY5w4iKmNadb4INpgW1eA=;
        b=BtAihTOT0R64sK+d+23KZfU1vi38rUVfa/bSFV4nBiP3qvCMEoMnnEK2Aph3AOmtKq
         2AzQnnFhaJbluDLKYvKmTEnqta34OHkPWN5MZFMwxuJZvRSv6J9H/IHjw0r9PH8Ow/aT
         b2YTLne3EVS1gUGnGx8RyYhlW4cq6PQfhcaov2N2fox6WwaJs9l/PLnrLfzOcHR3WHpw
         zwb8aJlYOe5KxJBIjFDvpnPWsK5pVztyzn4GpDG6Z/dfUNL3H2y0ALh5VbNjM2maTNiy
         uQqPtnF5p0pk5ECuIQjIIF0cNedS/NPiXlGfBZ9HPvn+d69JfsryZXhrKJ+Q+lQP3cZT
         0gKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PlUSMEI1m+InSB0nVd7HV9tBQ3t24BYOayZe2XD1dV2plAIPSH5+GfS+TQNhRRQoiUp/UdSIUF0k4Q/2gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrIm2ux938bKlMuVKqdENAa/QavOAqPLK2z/iesRGuLirAavFX
	URdpVzg7cy+UKWsbM0gx0uc/bgvKU6yzcRTe3Sh1PBqjeEMSA4eJ
X-Gm-Gg: ASbGnctap5O89LZi6U6+/hBB2JRQKvwxaQHQYHIQ1fjR3MTo8ZV9uU59zbMpPYWDTwR
	J+SRf1/sV732fuESJTg8ffY/BQs6VlSnDUVdpJPvEPEzdFuaaVnA22YKm1I7cFGmTsmLDQRSfND
	+2F7WGdAIl1CqBEwJn7mN6WTKMVxVZ8g1CgK5sI/6hVadxuW+dptnEnBGQZaP0FGOfQKmwh9ceO
	YhiSWBGIgqlaq1pieneaYvjHFf8ClnMlcysTJJP6w8y8W82tluPen8a1bmGhyA/AkzUeR1dsHpX
	CWtKdkcDGqJqZIYnpinihCtBxHjwT8FA6hA/ljZa8+ZENDK8k1OExOEsywKGKK6ajZyngi3sree
	NTA/5fUVD9YdLtdUg
X-Google-Smtp-Source: AGHT+IF1bw2/M4rJe7oPlREsRl6H7CKb+zSI/4ZcCobx1E7yiXEWmFhjkYKWpWSFZOo7fD2ufyGkCQ==
X-Received: by 2002:ac8:58c3:0:b0:472:744:e26d with SMTP id d75a77b69052e-47222944f84mr224990431cf.39.1740455732873;
        Mon, 24 Feb 2025 19:55:32 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e24400sm5295041cf.41.2025.02.24.19.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:32 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id C8CDF1200043;
	Mon, 24 Feb 2025 22:55:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 24 Feb 2025 22:55:31 -0500
X-ME-Sender: <xms:Mz-9Z7qu2smBu6OdQDdawB0_S1PDO3OL9dymZqGTa6jV6Bi6AdHMDA>
    <xme:Mz-9Z1qdhRJSwTxgURHKtLy8viiMNEQ-FEmQDeqHeCElPNaDKLJw1d-wlJDku7lwH
    5WmcZDsKzaEEeAkDQ>
X-ME-Received: <xmr:Mz-9Z4MzmwA6BaS6Mjd0TMipaPrtK6DBgfQwQ6ZQRsQq6X7Bwom1nRmZYg>
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
X-ME-Proxy: <xmx:Mz-9Z-4MBA6GNmmvuQJGHF8MKTEpQnG10BEof-BI9CqvcI1AnGpKtQ>
    <xmx:Mz-9Z64ZAyelYGL_5E5hl-rhzMLbQfC0-P4EiJFnVB2GxxUFNPgSVA>
    <xmx:Mz-9Z2jfsnZw34aKX-TakcG6fBXwxHkbXtKGOQ3-k5xzxjZYZ8cySg>
    <xmx:Mz-9Z84gXtXIC_NZlZLBuOipl7C6YI6Q84oj3mSHOWMiyOCP-Sn72w>
    <xmx:Mz-9Z5LYJVWtxCdE438UgxRcxHeP8cwHdH8qHSKrj2w9eByDD86uNv2z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:31 -0500 (EST)
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
Subject: [PATCH rcu 08/11] rcutorture: Update ->extendables check for lazy preemption
Date: Mon, 24 Feb 2025 19:55:13 -0800
Message-Id: <20250225035516.26443-9-boqun.feng@gmail.com>
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

The rcutorture_one_extend_check() function's second last check assumes
that "preempt_count() & PREEMPT_MASK" is non-zero only if
RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED bit is set.

This works for preemptible RCU and for non-preemptible RCU running in
a non-preemptible kernel.  But it fails for non-preemptible RCU running
in a preemptible kernel because then rcu_read_lock() is just
preempt_disable(), which increases preempt count.

This commit therefore adjusts this check to take into account the case
fo non-preemptible RCU running in a preemptible kernel.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 280bff706017..4cae119dece8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1901,8 +1901,16 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
 		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
-	WARN_ONCE(cur_ops->extendables &&
-		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
+
+	/*
+	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
+	 * as rcu_read_lock().
+	 */
+	mask = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+		mask |= RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
+
+	WARN_ONCE(cur_ops->extendables && !(curstate & mask) &&
 		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
 
 	/*
-- 
2.39.5 (Apple Git-154)

