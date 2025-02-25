Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506C2566F1
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455738; cv=none; b=lVoOMEzR9yMLkkxC5gXFS7O8IKEvogsvPZtpMompNXx4gvuPszpd1nIwEbN7iADSLpDCED0Cxqdk5Z1987hqkrE3eq6bK0CKdDbU3JbdqdBXOaXiMf+4zWfeVDjr7Jv5hn22NdilzJkOuu+3uZt2B0TAN400QsQ3o3bPpNZke6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455738; c=relaxed/simple;
	bh=IhkoHcLkUW1HTDPz7nFHSIO9D1UaWcIW0uk1mkBzn9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+Nzf2lW8a+iZqdBgOweYN4UMzWF3vzU9kFZE7sUCQtjdyX+gPAvjMqglHt4O2zGKnk5HiHhuPGoS0/695aW5ZpkTgOmE1tuVdYDJ3mExqZBJjwx+RhoKFUgZXJT6IUpjMhc+wQlqymvUHde3OhbU96VU0oHqaLszHlbc1kd338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qpo0Xlr0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpo0Xlr0"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471f4909650so48268221cf.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455736; x=1741060536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXC9zawY7wJtvjckwQj8TFr/iOcB1jE0LV9gQoKP54I=;
        b=Qpo0Xlr0kPz7qWkOY1uG/6Cc4QeGpUvFak+YIMXhZEufcbpEppbZkhMqNfSiHzw3ze
         QIkGy7uVg+A4gu74iRSlq/9urMiPOcNCD+Ro4zMi2NhaEiAodrlUZlN4P8sAtdKWsUhK
         1oRmtdjEotH2bAFLC5JLjf2xAwUBpZK2ETDdZIsNVVoVIWu3HqkZhUBIJhzIosK5kY5r
         cvt6JRFfObanpcypI44Y0zpPAUUuNg1F5DCli4R5r6yDDGPRHchcdkQp367QimDVKaxK
         G9FrQZAcYiYeC5z2/0v39rtXAxaOQgQ4BuE5FoWtkF5lT02EtRdu09+SnefRn9cAr93n
         iSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455736; x=1741060536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXC9zawY7wJtvjckwQj8TFr/iOcB1jE0LV9gQoKP54I=;
        b=uo2xFM17yJ/zAolZQt75yk1kOqJfFogrjGDpHCzuXirXvA18UaK/MumTAHxx6gLdrF
         jJXcYXqeopukHXpip8yIkgTy5pn6VkbK8//oeAoNYp269eZhvzhBMKRc/HLQyeiJtptF
         MBfdS2NvHgkHekDBpiyE/xTwUeAu1qSlygE6M5AF4MEUAZANH8k5KGQHnNmnVQ+e2F68
         vUzUpb9G+s6Qrg4xNBpAdGs8h2Gux4TMfyDlYlQ/r6uC7ERKoPBQUFB50nixDuX4wH/2
         5FkDB2tLY0Tqfx2G2BL+JdZtlpwX+vhs+CBXfbtBuKv4pU4kl6w5nDnxEsK6nd/27uvI
         yBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCsyru62sUFJKAizaLUsiziGTB2ypMJ5LOxSuYrOnpdHYswALBUXYpIROtyznz+qZjG03JK5sacuD27Undzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw++SkJ2u8iSLi80w3qy9j0du+l03kL3WIUZDDBCVeJWA+2ljx
	RCWr2+oeEpwdI5rbLNftTJ0Z7kysDroa2mEzkyPCewGkLCnableg
X-Gm-Gg: ASbGnctEOzoCiwx+0iKdL1thbMIUutBlhuVxSwglroO2QGjOWlAMX6zDUO25KGXPETw
	jRVCwo6bBpiwJGm07fVzIZpyzy+zcTCB+04oYumPa9gxqmcX8O/kQ/L0FfpNVqCLffRWr/zoyr2
	CVeLhGwosCGKkeTUTGVKlRRnN07fxt+RNMbZV3yNnRUcabUQgoIR5nh5yhpTCX1X5M27uZWaQ8f
	OdNTu1ONxYT2YDq0cSQxHErbBhzpn5fq3yIu64eh92hX7/yQs10mnPwDOgYDOhUtvhgVHxi0MI4
	29nCa8Lmz7xdB2q495QKQfk8SPdGaPdVK4gCgu1gIMMmMA9qc4qCcTzfxob+QClqTyRImPezUAV
	28G5K7uwzHwSvAmlL
X-Google-Smtp-Source: AGHT+IF0ja1Sg/mWiJyMe7MASVqniJnXWzUOGt9oWixkxEnaidRrfPol1LofMc9zJH82mMa3+AMz3w==
X-Received: by 2002:ac8:604d:0:b0:472:dff:37fa with SMTP id d75a77b69052e-473772707c8mr22740771cf.47.1740455736147;
        Mon, 24 Feb 2025 19:55:36 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e24caasm5271531cf.47.2025.02.24.19.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:35 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D024D1200043;
	Mon, 24 Feb 2025 22:55:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 24 Feb 2025 22:55:34 -0500
X-ME-Sender: <xms:Nj-9Z5gpLwUEVmEiMNzFLH1TF2z5MRVJFbw84AITSFs1uSrhx-I-Nw>
    <xme:Nj-9Z-BhiQSNC-4vtgfgAIXzYXgWw6_dd6gl4jOMDhQf-wgyU9R1KVz7SvVFHekTo
    hq5f026-3_dLQCTJQ>
X-ME-Received: <xmr:Nj-9Z5FETs7guUaqS1loXBmXD7loiYDHLxKMpkZ5e4abDEd-xJ9CJG_bNw>
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
X-ME-Proxy: <xmx:Nj-9Z-TjfGGwG10TA8JgEywmtax-TZNqQLlnkgJlKHEHnl7eYNvYfg>
    <xmx:Nj-9Z2ykX8GDx5Etcy0_Er8EUFWdA8dfk_oxdsw2VXNRAsXOnXbNCQ>
    <xmx:Nj-9Z06m6P8cm-giL490TcnWc0Q2QqNwZAMePKm95Iz6OzaidRw6eg>
    <xmx:Nj-9Z7x0_mEDYstQH0MkTBKVtxcVRD3A314djWeI1WFVcg1AT9twww>
    <xmx:Nj-9Z-hoOQSinSK3_JVRLGXLNRoCgXlJowZ40jnJXrsIa33TqSrYiZKb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:34 -0500 (EST)
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
Subject: [PATCH rcu 10/11] rcutorture: Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y
Date: Mon, 24 Feb 2025 19:55:15 -0800
Message-Id: <20250225035516.26443-11-boqun.feng@gmail.com>
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

This commit tests lazy preemption by causing the TREE10 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 759ee51d3ddc..420632b030dc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,6 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=74
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.39.5 (Apple Git-154)

