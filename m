Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826D19DF4B
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143949; cv=none; b=cTSNAhwoVhfnEvPRslRSFHeBQJnW2TswJ9n1+unz3YcpDpsfnlA2IX9dkvaygGRtfVLGu0VuECkoH0QQlv/RSR1io2aGFeE3OQIhPscxJOCdbilpMSKOsai1iO39NDalGzgY7HPNW2Cv31FWtJXblk/7aalyfGpzE0zBfhtW8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143949; c=relaxed/simple;
	bh=8zRq7ZAPDEtp3MVmA8IoDvypSZucbtkomFIWTGs/T30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3vMTLvibgux4gnYM2WyoEhZKdBIqbD/aQ+Vzrxse9zOAIsG0aufQFIqJHlHByXR++rEYjBdfCHE2jAvDdzKfTbZ/wBGI9PaoKQrwnpdt2pCA35/NTw3wez9+V/TlpLUPRwIe6LCtoiblN8bVgFgzy7zJ8pQUIuI7kWKidrpYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtU8kw/3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtU8kw/3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3d9cdb0ccso55684185a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143947; x=1741748747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pfiiCaIQ/4q3ANbC0HgoJrrFUh49fZ9FI7aYC2TsAOA=;
        b=AtU8kw/3Tg/9wBJiSZGTLjSbKlB0fsvkj3F3q+Y80L9yeqX4b5cd2pVyIRPqAvN8Kc
         WW1JB3F7uL3oO3pXCNGrjxn2JLksiPp0B/r/ZAv2YrrfehnseWDcgSCqrOuSFOEqKiqW
         fXriGSjzHoKXxTJex/zKDBdm1K5fxAwIhas3sFpJL1qPBsZqICNLP2hcEKZ4pS4hskpv
         D8GRQ2VDIrNcUxOr3FMRQnwaibw++4nVZqvSCkCdpkXrBofINJcSSYlKFuh3bKAIUFSP
         bnd9Hvl1/3myk7+8KJ2K6bznfctw9ei9cQ/SyndI54mhHPR6eMdPHKuS5YTTa0VbKSmL
         g16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143947; x=1741748747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfiiCaIQ/4q3ANbC0HgoJrrFUh49fZ9FI7aYC2TsAOA=;
        b=W/5Q0T2PaAg1f615fr22sAnorJVHaypunzXtrQWbAi9RVHVTROMxOFn02sw3LUNaE1
         yZ0Nf8spDxTHdanAcYfCEwwJaMBsjvfCJ4onWypdpa98owkm7BTWKzigec423Q5n59uR
         KF8y8fH4QP2GhiG4hsfsDVTOA0DEIwns/AT1wMT6pDjJ7EdlQwqxVWTHRAqAqxgxf55p
         VihAZ21hmN8gK29TpAL05HKs/lc3itxuMULe7NLxbnOQxQGWMTUNdT0iKP7dlXjGBVlX
         iiZLR+AJUbLwub2l3Owesxl18m85ePlicdKrwDOFARupT6KhzAry9n4ouF0rBXD7H0Yp
         gj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdOWtMH//5zAzA169lf6R50bTVWezNDobBg34HYZxNWIlVj0vjhhrj0t5HGWRu1V7H6pAqWKRoDC4kd4nIaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt3NsSVDHbdGwB6NjBgIWprXzwajiSr3Kji0JUaEkGTSKh4pBw
	RtBo2gEagsDGjEZmldRPBrWDWIkNuLe/LLJKOTIB5sDCQlEkJMNH
X-Gm-Gg: ASbGncvlrCXlE+gQhcblcsvYv1A3CJsV+kwMpWZin6nAZyaY4+icxIq+G4xLsOKIc5i
	uh6dWAMqeaRX9luLy5UF0Gic7YGBfagdYGADFdJVtm1WYFl/QKaQzHt50vEDoCdgRsIFt5P4mI0
	j6+O9vPBr5/oQ8Ve5hnaXVfHgHDX/deHwGiF9EgToA34PopvWZUYmneyfRhrikRjd6D3XSat3+H
	9VTQFCXuxtg1B+p6UOW+k0lpecW7daJofiWG/8vPiRoNS9RLxtASDfYkecAv8jbfIR9wq4PWsBN
	XRDkkIQj6ycLMG4dD/rg7Kthg4HMLPEORTj9+7Xa++GPfB8XtvqUsAbKfXXPFL2WvoDsvWiLJ8f
	V7iqssYeatI8TiHVIAoRPi4h5qZs2o0S2RDE=
X-Google-Smtp-Source: AGHT+IGSPnM2N0ins91abjkg9pNmv3v/fx5zOwCLPHARmT5szHhUZiMfGjc0ivQMHY/Uv2wzvA+SKw==
X-Received: by 2002:a05:620a:86cb:b0:7c3:c869:1aff with SMTP id af79cd13be357-7c3d8dec0a3mr230019085a.16.1741143946987;
        Tue, 04 Mar 2025 19:05:46 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0d34fadsm323062985a.12.2025.03.04.19.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:46 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7D64120006A;
	Tue,  4 Mar 2025 22:05:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 04 Mar 2025 22:05:45 -0500
X-ME-Sender: <xms:ib_HZ7-pmSBlPrSMVrVzAonR_f8qkXToU1Rhc6Q5d1oOtrMIuGX2kw>
    <xme:ib_HZ3v8-FWgaFjheIptM_PeeazukbLMWd5glvVR0wJJNvMVEOO5ppggmO20YsIYq
    fzu8VgQ455lcYAQYA>
X-ME-Received: <xmr:ib_HZ5BanrA6nWQQaXQpBwNxCNGItK8y7-X-Nd6AYLXmpdRkOEUGV7FEPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:ib_HZ3dbbRooXmi3hIeFZPvpZzf1OKjcXnmMeSiWh1Crjhc4eGC4xw>
    <xmx:ib_HZwOgtEBMgCQkA2ErmEolaB81hBuBNcNCull0GV198DmL1tgbdw>
    <xmx:ib_HZ5lvVXLZx3hXCGA_IUtOLTaYVFSp5u2Wj9yLo7LS98HySNuRsg>
    <xmx:ib_HZ6uLTXKJdc3RaI82it2cb3XRUUw_Uxu7MhmDXH5uCPPXjkEyXA>
    <xmx:ib_HZ6vm1GrTsPrd8zoBhyKmQ3jAFuKaHPl2qGA-KGcESYQZPKxLqpJ1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:44 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	cheung wall <zzqq0103.hey@gmail.com>
Subject: [PATCH rcu 10/10] rcu: Use _full() API to debug synchronize_rcu()
Date: Tue,  4 Mar 2025 19:05:05 -0800
Message-ID: <20250305030505.94059-11-boqun.feng@gmail.com>
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

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair to debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period is
passed or not might lead to a false-positive kernel splat.

It can happen, because get_state_synchronize_rcu() compresses
both normal and expedited states into one single unsigned long
value, so a poll_state_synchronize_rcu() can miss GP-completion
when synchronize_rcu()/synchronize_rcu_expedited() concurrently
run.

To address this, switch to poll_state_synchronize_rcu_full() and
get_state_synchronize_rcu_full() APIs, which use separate variables
for expedited and normal states.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20250227131613.52683-3-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate_wait.h | 3 +++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..4c92d4291cce 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,9 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+
+	/* This is for debugging. */
+	struct rcu_gp_oldstate oldstate;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 131fb463ba68..fb98d4d9d9c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
-	unsigned long oldstate = (unsigned long) rs->head.func;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-		!poll_state_synchronize_rcu(oldstate),
-		"A full grace period is not passed yet: %lu",
-		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+		!poll_state_synchronize_rcu_full(&rs->oldstate),
+		"A full grace period is not passed yet!\n");
 
 	/* Finally. */
 	complete(&rs->completion);
@@ -3218,7 +3216,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.48.1

