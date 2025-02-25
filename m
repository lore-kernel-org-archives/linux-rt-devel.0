Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D01EDA19
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455728; cv=none; b=UOz94BffK1aIwLIyVFEN3t0DtPAraRuSYLNL20pfhQM610HJE83GOcnOyt8pT5OeQ1voVBiiZA446hNQTLAK505rZ2Itt2EMXsAGD5ptLg9DxK13PygBN5/o03oxWsq9Am4aB8ASivY8EOWN+fLCqi0uf7f54wHFwCGAW/fY10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455728; c=relaxed/simple;
	bh=ESQAHp4TWxX9hz7AnJ1W2Ktm+D0hgjSpWAQVAhkjhxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LK+yn60+xoqSni58fizn/zI6WSqaSlwC5Z3vby9TyGXmnMUTd/fnauKQleRNHSOoXdHwQNcdeWDttFHtvvP7h9KgKIuXx5a5fsVZe3wGJ4UonqXtGnpz0sAijEb42Ht/1LaQAHZCVSC49UsGijEdlhqCUr4Htsw+7+TxRoAX3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KScMN0Wx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KScMN0Wx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e67fad4671so44877406d6.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455726; x=1741060526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsyEkD9rvPtl257B6PtlDCoSMiAXhw0HwIEgtCwXoUs=;
        b=KScMN0WxKvIXr9xN+lQwUKAsp4/CtHyqhkegaOlj69oNZzzGIqpdbi1iT20bHPaWv5
         FXdZNvkKFS3I4RZ1nZPO9HHxrAENSCpEmDThREwTVVEqSJds5fZWN6We5CDNmISbdj4C
         qxn57L7ZJbTitqip70K0fW+Sja7LreCTCH0nv/KQLTvRpyfF09TPsBPnmokcEe2lQzAm
         tsNFQq6g6pHZJJ0mp/Z/1azN+c/FKLhMFjSVXFHfYTzOOk8X1bOEeJhv6mgrDlxoDJQv
         x2uB/eDV1iQp8WbkAd7PIXp+BuUrKisMAa1irGKiBOIAB0ZNgf+V+xI0d8H9EntLbmoR
         hCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455726; x=1741060526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsyEkD9rvPtl257B6PtlDCoSMiAXhw0HwIEgtCwXoUs=;
        b=eEDFXGT2WFjiVZ57RyZm2n3ol1q/XF7GIMaIDvi1/08Cp4ZwzoEXKSkFBYRG0c9CyX
         /+wF0uqXh/yu/y4Umm9ure+QjMDDIr+PQ9Iaq0oQwM7kEv6jxDZwqS1qCynjZ2CU39M7
         Yyj+EzCtJ4RAK2nd12m+e8Uh65KzNQg312dOr1rMM8qRNljdLnNMg0A5Si5r9fTWjoBN
         G972RWQaXbDleL9SnanPyU/W8UtzXqTbSFZ1hhYXP/zZIiZneXbrUIWaF66CM+idRzWl
         DtrBc/dSMeQppogES2HbqmsEnMgduKNesi9SxDdk4KW8YUuM2H36c/E4WF3+JY4FI/0+
         wa3w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6gup+wheUyy73+b7fHa7Jdydx+2svhZtH6H5HUz/b1prIVNK4ynAi1kXNnjggv9k3dycpw/7mx4IhIcY/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YycZCLpkpzZNHQjhuXeVnUBQBA8Aa88pLMI/FL/QeYfidLRVrvs
	mW1Vxkd8cCu9y/FwuBbLhn5hiBpK0l619q2qrxX1Q2ZEDNFy0KeX
X-Gm-Gg: ASbGncsN/geAG9G1yhg3qHFeaZXWv1pGDoHlGQNZBHoBVDovfVaVb8cFkctzLYPDX6H
	y5Xd1s0rPqzuvY2q18b+w4mb13YECiA8/ik7ahMuewWq8v8Ubzg2XM2gmBDZz7wCWnyVXUXlNWw
	cro3wzs63WD1KY+V12ouY10R/2bezQTuXMd/8hxDSY3IIHTc8Gs+C/upFpr02tJhAjsdnm97UIK
	2IZmZAwq2HTOukadNsZqEXD7slXOfoVfC856wzn9ODFCtdJBVLleaedSvM4SaWXJjAAKJBxYIw5
	CnA52DEKQ9St6r3jonsrFM8mR7ou9zqrZWMQ8WtuobP6VMyYjWCs5C+Gha3Nn3qv7SMQxDMzJmB
	kSFNXpbw5XyneTs/P
X-Google-Smtp-Source: AGHT+IEBeyRItTwAFtwXFvI+3fMU/jftvMugN1ITAqxt40ZuJAixUMZ90OXiQu7DyBZhCeUtaj/dew==
X-Received: by 2002:a05:6214:4009:b0:6d4:1bad:740c with SMTP id 6a1803df08f44-6e6ae7d0bdemr193820706d6.4.1740455725715;
        Mon, 24 Feb 2025 19:55:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b156266sm4971406d6.85.2025.02.24.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:25 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 832BF1200043;
	Mon, 24 Feb 2025 22:55:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 24 Feb 2025 22:55:24 -0500
X-ME-Sender: <xms:LD-9Z2UJ-MRDlJ-wCsFBUEkKG4QQgJK5_qaUMeqmquR5bRa8fAdjjA>
    <xme:LD-9ZynaHj15l04jZhWNKTlq-hnHHrt5ds_Ln_b6zPUxpW_hJRaigu4icYCMSB8Pj
    dK71GfriShDFt1UjA>
X-ME-Received: <xmr:LD-9Z6YRUGFfid-2EMTnQuYmzXFAiBjX5Xkf2lu0kXfUiJeHGVR12xbJeg>
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
X-ME-Proxy: <xmx:LD-9Z9UT3twBgKFUprsUKAf5ab6QyAqPEh-HkmBdJZ7lb5kcxTM9aw>
    <xmx:LD-9ZwmU_8qpxz4Iygr_3IKvdKIJ0kMY9aHLF2NYBQVQMvDn5P5u5w>
    <xmx:LD-9Zye6BNXao0-s2KkUgKnPEBG-fMnyFZmaF3a-We7Ffn4nKn7j-A>
    <xmx:LD-9ZyHe09KOoJBTRQULZ4xNvpHyaA3bcbL82hx-tnTyyeBJHXqWXQ>
    <xmx:LD-9Z-kG5IqPC6TtiE1h0WNPAjXeTPG1GwDbJUZm0u5S1RaPMCEWmo0o>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:23 -0500 (EST)
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
Subject: [PATCH rcu 03/11] sched: update __cond_resched comment about RCU quiescent states
Date: Mon, 24 Feb 2025 19:55:08 -0800
Message-Id: <20250225035516.26443-4-boqun.feng@gmail.com>
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

Update comment in __cond_resched() clarifying how urgently needed
quiescent state are provided.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..d328707626e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7289,7 +7289,7 @@ int __sched __cond_resched(void)
 		return 1;
 	}
 	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * In PREEMPT_RCU kernels, ->rcu_read_lock_nesting tells the tick
 	 * whether the current CPU is in an RCU read-side critical section,
 	 * so the tick can report quiescent states even for CPUs looping
 	 * in kernel context.  In contrast, in non-preemptible kernels,
@@ -7298,6 +7298,8 @@ int __sched __cond_resched(void)
 	 * RCU quiescent state.  Therefore, the following code causes
 	 * cond_resched() to report a quiescent state, but only when RCU
 	 * is in urgent need of one.
+	 * A third case, preemptible, but non-PREEMPT_RCU provides for
+	 * urgently needed quiescent states via rcu_flavor_sched_clock_irq().
 	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
-- 
2.39.5 (Apple Git-154)

