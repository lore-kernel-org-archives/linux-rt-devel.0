Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AC253F30
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455737; cv=none; b=sSI/pLbnjYWKkUu4YJ3YkBhRz8Z30ESxVO86l3LGa8sKtmscEBFfk25HDUPsBU48aFSRz04spTHiGv0gDqy2a9m1vq07yfYY9V+8bILeAVoBlBKDJa5j4hV6uTQA7mFEtJX/AMeHlxTuk8hFT+nmWQv819DBL9Ur9Qg7Dk0Dy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455737; c=relaxed/simple;
	bh=tmww1+SJua+4wlLpPC9mhEo3DKU5TCZTK6AeKQiu02g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Amyf7vEe/AB95M7uP0Rl2eey3/Lppocf+NJ+Gh//azPFrxP1uomgcqJwqwUgiAhXf5pz9CRu8hDGYflx8/YjFLainufbfMM4kpWgBqDvAjQuJyTJ5jPCv228RGzAZHfEIa/aKxYHiPgiBrwBpxmmD34WRnP3QZHM2iqvTWjeOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3mfbG3o; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3mfbG3o"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6c082eac0so28451566d6.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455734; x=1741060534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9uLvu0VnuSfBzmKR1xOZZZMcPxk+1xKCMKGMXIs8E2g=;
        b=C3mfbG3oketgE6HCPERX+JjsUhTG1gNtm9i4BpXOReRnwcwwekmMO+oLugME6ZqiVs
         /dHjoyLl9DkI9VPzUWzzun+OKAleRjBox76uRp61U2eYReWgUsebnjj8zv+FzDCP5EF7
         S7z3bQoMkOUsop4CYeHybUfhtc5161N7tqZ4bKMcSq/av9ikVIER7jwy5ByZm4/cdzXp
         iRspzjLPvovWvbdwrRvP11D3e8y3y4r1fLo3HPfZikD4Kru2UIAKkPg2bcut+J+R/pi2
         pkuUrDZMSrsoZ8bcx0647xpzvIyPG/dgyof476Asiuk1TMvBCVZYv4Xto77cKCYr2AWI
         ZJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455734; x=1741060534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uLvu0VnuSfBzmKR1xOZZZMcPxk+1xKCMKGMXIs8E2g=;
        b=jR/DvjEacsWAQq9kqVL0eudiZdIk3qSsHNDPBCrCYfrkivkp9SIe0K51uhkRzf9+L9
         MLxvgqG/+uQw7EfMlY4YeuHWkG319hBQkKA2EmaqurAx//XAQnAlLcUoCuIdA/31PBfS
         r+Z4/AjD88xbypnvpz8Obi+6q6Cjwg9/LjGIv9i2mGhs2XQcqwAZ3uSY6y4ZpXZiWcb4
         1LkT1x6QQ7PtqRGDYzwUBVPq8z3r0dQiIyI6NOEolRbEO/PESTyZE0jnMfBjwqAZApTT
         KtfCihKqOiTXD3HU8jLXVYpJ3CG6R8jBz8BQ74iezITCMOxbbW6YbqaG3z2z/ekDn5VH
         QhGA==
X-Forwarded-Encrypted: i=1; AJvYcCXghcntn7bw05INcOzRUE7OsyhA4x5D3yQ3rlMnxmhe+b8Ldmr8GdhrRfVmq7rsp2dTfNGc5Sf2sygXEKky7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXBpN1UxK9kmtFzqjsmc2XGOuqSEnu7XgHqsbDSHUPf6crwzBx
	umaxv8QoiNa4AeZs0MM18Rpb9U+ycoQp0pm4OWtIV2xx6LMnXfQt
X-Gm-Gg: ASbGnctQ6v205bU8kwylcZ1Husf5edQmw8VSwSLro/RqgdsxN4Nno68bGl4Xhfmh5l4
	PXhPpw3nlBIHx95XNR4L4s3JKBA4vVUK/oBIGhy9UP8t3ZOSWIsr7KJYKwZ96WJqqFfl5zFk1tM
	zvHxdW93mzWoslhY5AfJR2pJ/Bf3VYEaxA4jggvp5+KyOA66x1n29QdC2VKP3Yz9OAn/e6rxRci
	Y1bgr5ciT2xge4E6nsHhPl7neDRN1lSzxg4kYvMZP8TeDJNQwvetLbpVjpWX7G9jNYWzuffl6pg
	f8KyeHZfoEhvHJRWCXkDVF0ttfkTdy8oLHKXfPHJZKRinarI/KYS7jh/OyTJg8L4JRaitvzc73E
	Q6w7qUnj6S1Z12wuw
X-Google-Smtp-Source: AGHT+IHYqFDwVuL07beYvSc+yBY4v+L4a9R4xbWY8aepATv/v35vL6NgV1lYDMvgzLPG6DxzRx216w==
X-Received: by 2002:a05:6214:5190:b0:6d8:8109:a547 with SMTP id 6a1803df08f44-6e6ae829130mr225550176d6.22.1740455734598;
        Mon, 24 Feb 2025 19:55:34 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b153fc2sm4985826d6.77.2025.02.24.19.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:34 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 481D81200043;
	Mon, 24 Feb 2025 22:55:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 22:55:33 -0500
X-ME-Sender: <xms:NT-9ZyjyCAoTaPhlpYteWoMs6OOBVvYvEOztNh0qpAxUpGDdaPBt5g>
    <xme:NT-9ZzAnNYQWKMPXVWZ8LEzyI1BowzTv2MxH_o8QHt3ih-sK7ICrEIq_iwFP6RcSN
    hhxIKggzrhQEn-Ieg>
X-ME-Received: <xmr:NT-9Z6End8ORhXmX9Lq6X8DG8yStF28pyskpX11XsmrMq2hbwKOf2_YZqw>
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
X-ME-Proxy: <xmx:NT-9Z7TxpbJcepic0C8NdyVUC9JvvKmf_RNDFnJjnkT5kZvZTT9yzg>
    <xmx:NT-9Z_xlA04XsBMggXa1nzzRa6ykKUGMaqYV95YMAZg1oxna7Yd1VA>
    <xmx:NT-9Z55wSVL0VIK9YCiyd_rYDR8iZgtx814EiXLvMRKwHk-M0ZmT3Q>
    <xmx:NT-9Z8x4uEwooAMhQCelSKqBHdjDXkdAfiJEVZoyZAtey0weRN-tLA>
    <xmx:NT-9Z7iD07NCVibWbQB1LfDjrFD_SIIa1r8AbQH1FH8dEhkkKCZf5hEy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:32 -0500 (EST)
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
Subject: [PATCH rcu 09/11] rcu: limit PREEMPT_RCU configurations
Date: Mon, 24 Feb 2025 19:55:14 -0800
Message-Id: <20250225035516.26443-10-boqun.feng@gmail.com>
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

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of PREEMPT_RCU or not, however, is fixed at compile time.

Given that PREEMPT_RCU makes some trade-offs to optimize for latency
as opposed to throughput, configurations with limited preemption
might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
model PREEMPT_DYNAMIC.

This means the throughput oriented models, PREEMPT_NONE,
PREEMPT_VOLUNTARY, and PREEMPT_LAZY will run with PREEMPT_RCU=n.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e2206f3a070c..dd6251678e99 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.39.5 (Apple Git-154)

