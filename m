Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563912C470
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455725; cv=none; b=MwIPXOseVQeONDt4dt4jp8wanxVIHPteCO6KEw3vOazi23vSksAxOD9053ICbrFCy1QCao+CdfxrYPQ+pJViEa4/qDB6wRPg57ZP41kfUwDOCwgBuvTl0dRcxtH8KHSsZZvS3h5enRLdsenmu6chb26BS+JxYAHU+KIEFBvgn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455725; c=relaxed/simple;
	bh=Zn31EETp8TJfWpBU9ejw5q50uSb1zcIQxp4Yl0+1bcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6469QCvjTv2NfSquaC9dhu6gqILg4AWs1Mq6WlYb8Q6sy6bVk8XKIn/3UF+FOaLtzZSfg6SVbB3AW/kR7SKrOMOtUWXTgsqkpuD6Vft/FlfUNy11QgMvobl8uD4qciH2wssqN0Bae/VSnN75eEC//QQEzGwo1fEHNxgraYjW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7vMAJ9n; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7vMAJ9n"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd420f82e2so73283146d6.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455722; x=1741060522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WkOpGtQNsRJi/XKiVrTpjQ+EnHtEuuYo1UdNJPBjtUU=;
        b=O7vMAJ9n9KLG9j5IACB2vBBkBQW9rgjvGdqsT6GsXorL4weDvkUUSqXCTdPFEExgNP
         CtK5aBkcwQ9VoBzmWtZB+NecbzZ1VJdFjRy99elQjyXABg7wmIRMmmEqS4pDptUacZby
         xmqsp/+VVpiF0wRpxXIp7xC16R35c1OFqCQvt0Kb9jz9vVkFmpFhQnIyyktRcpAJ0HZZ
         5GjvcBnE7oXAVq7rdORex+Inhu5hATbZu/FOv1mVnPxo760rv/Z3QE9fL9N/SurQ+cV5
         SEt+ZF6Tf51d9cOkOR1dqiv95e0d3MBzQqQOuIp2khD4+emN8s8yUXm86nSCgqZTVX2t
         pmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455722; x=1741060522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkOpGtQNsRJi/XKiVrTpjQ+EnHtEuuYo1UdNJPBjtUU=;
        b=WGsZUJVVpIvAmMyEG6VU/NRrk286gq8tNIlHuCoGl2eA5FJea0C3j9x3NXmKyptzU0
         o0tuAdLBqY4Y9TFczxhsBXDtdXJWb+f+28iuKJcCNpqgBmV8A9j5TpODmoV8L1WYP6fB
         v+ZTAI+0WJJCaVmTvuCpY2XeBABOv6WkycCstoq7N/i1gvnFJUTzNv4d2aN0hThEMG5Y
         acMHbimxus8A9IF1U0N+b2/QB0+8Pye1eiUPTqV9lNs1WwKfxESVxWvEWhG0BuVE5jEl
         wYWchZeplL6JS1zZTusEHaFN9lIFnGsxshuoUYUkd89on/KSdlTzp4U+f6jmVI92H/Qt
         vPQg==
X-Forwarded-Encrypted: i=1; AJvYcCVBH3qQkhSaJcDYfmIS4QrsjNvAnfJJhd4LjJxiooAoLYRXpI1lsRm7Mf5E2UUAooQvxMBWPbntyJITWSMw8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYR1tiDNlLCVnVgqpgUlod7fqgkBRfHcYbD45b8yYNPva4HekP
	XT/xeRg/m1WTNlkwerySvYYZxTPo+RNPKfX/RvyBNPQeAFgyaASb
X-Gm-Gg: ASbGncuox6JKNsMDBVD7+HPI60jDjv+BB8Lgg9qRWnFJjPYFIfs7WokTOCh7nl9WFB5
	fprPa53KuiVLGJY6+GJCOdgF5Ds/HJt2KvLJktfq33xiBD5V+G9HGfIPJYPpqnWHn2u2j8zTJ05
	V/S22YR1eK5QOYiJcujQCZg8i5HvClRhVLf8QpfhcJ7qSMZSzXZTnKDQNZLfJlTx7GEzzYK0LMO
	tBNISJeqjiNTDDnSM3sJ+yJ5mxHDubMBoVT9weT8wcZAEtK3cwayjvnODfBaPuF8H+QzMWOvMqd
	wWZNJYd3qcfXkBApr5kyVcS1sUNp5Gpxd+JVA4ror7N9DbCVxULYRMsv6k+qQVMuJZ5CgVeWrLM
	8LJ2QXZzSj9GGpNPQ
X-Google-Smtp-Source: AGHT+IHFM7nCfANUJnQWs5ua173vFVnzmAQXQGQ66e13i/keK033791LhwthqRphswwZvNeSbnygmg==
X-Received: by 2002:a05:6214:f03:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6e87abbab41mr27890766d6.37.1740455722610;
        Mon, 24 Feb 2025 19:55:22 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c29930asm61016285a.2.2025.02.24.19.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:22 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6EAA91200066;
	Mon, 24 Feb 2025 22:55:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 22:55:21 -0500
X-ME-Sender: <xms:KT-9Z_kaZ9Rq6BKrCRZJiraP7DyeF3pc599Z7BrWQPL5STD9rGKCOg>
    <xme:KT-9Zy1OpCWednp30ceay1BHyLUGfoWfhyOJHacs8qdYQVv0gDhOioatdwnjucAlx
    Fgik8mBjb15y72s8w>
X-ME-Received: <xmr:KT-9Z1oPDrQ5gJeH_OwRc0iT8KRXfDjk1r9vuIa9NYWsgZxOEdnpV9aSrw>
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
X-ME-Proxy: <xmx:KT-9Z3nRosNP6AFzofi6IrVMGlBAltQ5fiACHfRHPwq4KoPEP0MV-A>
    <xmx:KT-9Z92qVdr1RDeXT2r7JbWXHSAyc3_kvADI1xF7m9oI_p6NHL_maw>
    <xmx:KT-9Z2vqnpg-unPB1pYEg6GyGrVzq3Of7SGGn6sh7xEqmTYuMe92mQ>
    <xmx:KT-9ZxWDhxnUxIMpTwV0nYtg0i3F3ZqP25TcPYiDSvNGsJSi19tDwQ>
    <xmx:KT-9Z816hLQ4AG1L9HUkSxMIRwkY7kchDF7phn27_854sN6-euu4s6uf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:20 -0500 (EST)
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
Subject: [PATCH rcu 01/11] rcu: fix header guard for rcu_all_qs()
Date: Mon, 24 Feb 2025 19:55:06 -0800
Message-Id: <20250225035516.26443-2-boqun.feng@gmail.com>
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

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d912781..aad586f15ed0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5 (Apple Git-154)

