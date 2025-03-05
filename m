Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E71990BA
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143943; cv=none; b=fT21d+dMapVlK2Xn5bP7H9GykJqsH+XRL/1aDmx0bKZlSMr9lEd3WefulqHjJu0jVfUyq74tk+1Voa1p8cybquK/e7fQsK9MnyRmtJYzEYHH4aogY0p9YFV5jN007bWdqPT4C/oi0meZiJHWPmZOF5YJ//wiUiqLQcOccJ84ICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143943; c=relaxed/simple;
	bh=FTbCxoRNzeptyiCsRyZeAdbu5kGrrtfegvCbyVJPKRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdRS7IH036ZUtb6Kn7FglhkiUuxMcRZArhvqMIYjEKFZCg5MCx4eSAxYGFaZ/lwRBZXSSUxUzAC7uGDPZ1+wQ8XfM4oj+Y7U5HNEz59GbckKD2OwjdiMtp5fmGEswL/iTtJ9MwDJCWYbw1xkXdlfDMXO5DC/mkUGXW5T2RwgX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGfkAoXM; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGfkAoXM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3b63dfee1so332853085a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143941; x=1741748741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6CYER+QWDFGbqGupxQEB5sdNaMc6sLr8skppdSjdWU=;
        b=RGfkAoXMKvb+K5ZdAQ5okDa2+jf+5W0/nWSL24H84KxlW6ODzhObVEpLVHda9DHH41
         R/eza5g9F56F7ZyH1I3G8R6BzwgaII4CG0KexPfp/3Ga6bI67egZVghVk07ajIXw89Ws
         W4Bkt6lnUbor5vgRf+KgICfwd3Jb+fV7hdqjq9BDVEXrl5izT16lxEgV9kCir2cdpgWg
         JGabt0EvrEpx0B1lDD4a9EnqL8E6k2eYs2h6u5ERonmLTtpzFdw7AXI9zLtf9sm3GvWn
         5OLVkkITM81iGJ1bTCSqcT6zyJ2h9hm6zdsn3W800CjMjAlRfbrw1DSIVndar95MTkn8
         iOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143941; x=1741748741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6CYER+QWDFGbqGupxQEB5sdNaMc6sLr8skppdSjdWU=;
        b=fMSbbJQSZ+9QFGEEJlSd8J/gxHmgdxdlCpXVviJ3Yi3nXiYhcLpUUZOw6Xy8BFJp5O
         0V2q2l3VdOkQ1pe0vW4q7zpAS4r39ppRzhui5mQ2H+4VbzYNC0Lej8mPXnvsY8hryVsP
         GOE0uPWPW7c16MY13+SnLr5gYLNjQYLU1Kx2B/m6fMNzFVdGIbqlXXAeQJgiIS+7cSht
         DBT7vGVhAWBW/Z5iF9/Ui6vOiCMlcacSIEbcT1cvX8QyQbDoic8zAyz+81YEbqJEm4Of
         ZCdJ64JYpL2KIpNrj+rNuOgsw7rciqIFyVbyk3tfLVvMsFZ7ymzHt7hsRgTh+UOG/ig9
         lTRA==
X-Forwarded-Encrypted: i=1; AJvYcCVnXLUlg3t71EeNjNLblRmRAGv2y7Y9HWcZbjqVmGeCCOBgxwqRR93mED/JKuD85LZOGyfr08OH5TEYed4ptA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKiCd0vaN3sZA1kNkVbtUkr8A7/MOelhn2L6uUlshne2fJEy0O
	SvaLnuWsRwKxpnLPjqK2n+ntogaq6id+xHWKt8cWLjeaUTyjg3xO
X-Gm-Gg: ASbGncsMtk3VrlH9+sACYJDVoWH1MWTwB9UvTK8Tb8w+psVfWZVsebc5N3Ms5IKcF+T
	fY+zoR0yxnBH73eNelzXjekDkcPa3yKx6o3MGB0wauYaSgRbYTHya8T8WGq8hgFnr7YxGS5tPB/
	0Gn04BvFIzyy+d8Bsux6dvjyp6lzhAuzfiRJV5uzCzfHGHxPihioS/5EMcPaLd7s6PLXBGl4kuu
	EQKd2N5FNbgqbTpXRvIhl7PQcj18zc3ra34HEeRXjPnu+7A0uKEr/BeOb/bEFknBD6t22BD+pI7
	F0lApzdi0Ybp9KMofA2iyB5OU61J78w1NTGhZb/2ckDZARSTh7tTjwQYhomoN3Ij1zphETMWJag
	YuW6jx/vXUan5apy1tOXHdaXW5fNE+jO57Bs=
X-Google-Smtp-Source: AGHT+IFFQiKwXNk+FSZRxYuGGL1vRU4+A1PP9vowX0NB2SJbrCiTrutdhkP19/BkACOv1Vq3pcdscQ==
X-Received: by 2002:a05:620a:6887:b0:7c0:9f12:2b90 with SMTP id af79cd13be357-7c3d8bd2be6mr306010285a.6.1741143940679;
        Tue, 04 Mar 2025 19:05:40 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3cc0c20ffsm210181585a.91.2025.03.04.19.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:40 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F431120006A;
	Tue,  4 Mar 2025 22:05:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 22:05:39 -0500
X-ME-Sender: <xms:g7_HZwoI9S3YbbAnHf1moH797XFX3UyPuvIXmDQFzTrBpPTKw0P-ZQ>
    <xme:g7_HZ2qEuxNyNjEUstgVK9wgbX-j7VjMZVBJb2N_qVC6779E_olqTDjHEynNv5Y8v
    x5yx4NW3fsiuuABzQ>
X-ME-Received: <xmr:g7_HZ1P15tTlF_NbxQnR1dP6l1S27xzsmFiXRrbJgwYiQgdyfAXciUjpPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:g7_HZ35yJo5JC9T3C3UBjJiirBDHIIGMOrNm1pNmTjrppmyrTx2pUA>
    <xmx:g7_HZ_63px3W2ID3AFigu0-VMR8SKmhPwuC1EkGDwTmerElniwMS7A>
    <xmx:g7_HZ3gnxrJMYKMGLdeYWpeIPNNL4umh7WEiqvsHYjcz8GEzapWHnA>
    <xmx:g7_HZ54vEgvP0Jcf4MV-QDJnuqoluZoJrnsNKHJxMciZ0Zr4pEuGyg>
    <xmx:g7_HZyIH3__g4X_Tka2Cc60lNHQKEszLrjTohkY_Gsvp2dvArTvvnB-b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:38 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Yuntao Wang <ytcoode@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Guo Weikang <guoweikang.kernel@gmail.com>,	KP Singh <kpsingh@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	zhangguopeng <zhangguopeng@kylinos.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
	linux-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH rcu 08/10] rcutorture: Allow a negative value for nfakewriters
Date: Tue,  4 Mar 2025 19:05:03 -0800
Message-ID: <20250305030505.94059-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305030505.94059-1-boqun.feng@gmail.com>
References: <20250305030505.94059-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Currently "nfakewriters" parameter can be set to any value but
there is no possibility to adjust it automatically based on how
many CPUs a system has where a test is run on.

To address this, if the "nfakewriters" is set to negative it will
be adjusted to num_online_cpus() during torture initialization.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/r/20250227131613.52683-1-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..726c2d63ab66 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -147,6 +147,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
 static int nrealnocbers;
 static int nrealreaders;
+static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
@@ -1728,7 +1729,7 @@ rcu_torture_fakewriter(void *arg)
 	do {
 		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
-		    torture_random(&rand) % (nfakewriters * 8) == 0) {
+		    torture_random(&rand) % (nrealfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
 		} else {
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
@@ -2522,7 +2523,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d\n",
-		 torture_type, tag, nrealreaders, nfakewriters,
+		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -3597,7 +3598,7 @@ rcu_torture_cleanup(void)
 	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++)
+		for (i = 0; i < nrealfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
 		kfree(fakewriter_tasks);
@@ -3994,6 +3995,14 @@ rcu_torture_init(void)
 
 	rcu_torture_init_srcu_lockdep();
 
+	if (nfakewriters >= 0) {
+		nrealfakewriters = nfakewriters;
+	} else {
+		nrealfakewriters = num_online_cpus() - 2 - nfakewriters;
+		if (nrealfakewriters <= 0)
+			nrealfakewriters = 1;
+	}
+
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
@@ -4050,8 +4059,9 @@ rcu_torture_init(void)
 					  writer_task);
 	if (torture_init_error(firsterr))
 		goto unwind;
-	if (nfakewriters > 0) {
-		fakewriter_tasks = kcalloc(nfakewriters,
+
+	if (nrealfakewriters > 0) {
+		fakewriter_tasks = kcalloc(nrealfakewriters,
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
@@ -4060,7 +4070,7 @@ rcu_torture_init(void)
 			goto unwind;
 		}
 	}
-	for (i = 0; i < nfakewriters; i++) {
+	for (i = 0; i < nrealfakewriters; i++) {
 		firsterr = torture_create_kthread(rcu_torture_fakewriter,
 						  NULL, fakewriter_tasks[i]);
 		if (torture_init_error(firsterr))
-- 
2.48.1

