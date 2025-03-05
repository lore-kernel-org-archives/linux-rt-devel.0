Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF22E3393
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143914; cv=none; b=fqetFFIs1w5t6xsnHNhcpkKsAxpFJuO7BfcgM/77JyRpDPiZlsG9VrWVP0NQ/1vBmAczm8O09mZxRIfircrG/65l+GNB81WtZ3zrY3f/wSqg6+45j87aqy4hyXWMOsnyYWRu4+E2lVyAaUTeTc9doJJD1P4rIpfAnP/PUrWHWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143914; c=relaxed/simple;
	bh=uIzTrgOptV+UJekRK9fZqgVZ4HuhUabXU00kNLk3AQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8ZTKJ3OtILmqz9z5Yi6WjB6gR5nwCR3/D1fUSm2pVuoF6WkpjYSqk6uw2EMwlZ1JzRm1VFCNDqihV9/fEtjM0AmhqQb8BUQIrnI5/40PmDeijVr3lIIr7KjgviMREhtfrNZ5jp/CKF8/j8LvSqrWKONOugpOPEJpng6wV3qYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbm2LQlf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbm2LQlf"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c2303a56d6so686030285a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143912; x=1741748712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TtAhruDk29bBD+n/3w0sFbMJ4Qpp/JAWf4U/2iqtCyo=;
        b=lbm2LQlf7UFEMvcqqDm4+8ERFo9L1XcQOg4cVMRD97Kvoe5PKlkRcinuX2+Oms26xQ
         stc8F1oXn4rIOtwO7VqcgQEaOZQpVbzCb3J06Dk5/xVTIpWlr5fPmfd+uh0LuuqNBb+5
         /y4j+gjaigKipF7pg5DaN69axo6V5HuSn8t4V312Ny4/d9qZprdM7Kw1UBT4XTPfkAqh
         GsvxKS59YkKlv5P0ABoxyboFE31/rXPTY4q/TOIH4h72hz7CfbcNovcL7oFHA0lPw+H1
         9zczqCt8niz1l6jb87uHlw0szHRUq5RvG5jC0SDsfbQCjyczbBOOoKZnZNKH9Vzrj27k
         afbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143912; x=1741748712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtAhruDk29bBD+n/3w0sFbMJ4Qpp/JAWf4U/2iqtCyo=;
        b=QE7T605hqWKaah43880VmhxspwwhWk6jgYItxWUuHvxaM6M52yCR/6QHF1+bS8jGET
         b+17gATdAjgr7jhWeIk7/viULSW7tLcG9QvTU095aMWSaPLLqAgolq20VIuNMST8YUpI
         803g8Lg7Lt99T81nji8MWSkVW1BdH/VVkV9QdEf8bZx/FJHlzd1xi5u9HPKBllUxh3Dj
         7ubMwZ26nNV00v3SxiiiHT/K2uv5r9UNwSawxsbp6kyYBLkiGyZ5f9m445AS8778lbQK
         JjBgzBy5yN0mWI3oO6Ym9VT1kXZngmkOwcnclrb8Amg+/fItzwqt2cgL5c8cehz2wbtv
         hrtg==
X-Forwarded-Encrypted: i=1; AJvYcCWs0qHV7gzZ/NHtlHIR9ZW+0x/ZRMUzSMHaiKg5YK+DxpmHUd0aLhEQP/jt5XR5RRWFhnLZf5a993ANncgDMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4gfg4viLzXFOx/ylwUpES7rCuANrE+efWZLScgzbOuXC6zcXa
	x924E3Q4/5xfdec2EaEIQyNVZlv8LrLFcPTirC9sKiy504qe1LAe
X-Gm-Gg: ASbGncuTCHpDRBBQEKHZ93RB+iGhbbJVXIUAML4TGi998b+RbyllFxI93aIkkIvRAuk
	RMUPDGmbLgRUwgkwY4qHoBuvk4rfKgffTKwctxklalqBU9N1cvA5k0BNZnsIbkwPUJEDKr8mgtC
	bKw0qAEIadFOCUlIC5fbJBy0jo7mMc83xjJs+UbZ3T/RfTLHPmVdYPM/rkGxO7hKjMPrsbRpgjW
	ENgvY156w2+13X8ZDf5QRf4j5p1bWMqOnvzx6zODVeHbDDXTLUPlNM+52e5S/HaClnGPGcl36ss
	QZO86oVlkESBNAc8ZPM9FYL3SiwfhBrDocw1rxEUgPtUK4+mRJ83QkU5gSx8V2Xngz8t2Y3kIbV
	mOQKwXkDhJ9x5e+XDGPdYeuZej+nG4QdKfVE=
X-Google-Smtp-Source: AGHT+IHwQLXuLEQr6SIyS0fEOaahuVSMv1SsSL+2Iy9aA+a8PVMQN3EvE91Y8mnyVFrxKHSo2M8kYg==
X-Received: by 2002:a05:620a:6190:b0:7c3:c3e1:3200 with SMTP id af79cd13be357-7c3d8e4638amr284054285a.1.1741143911563;
        Tue, 04 Mar 2025 19:05:11 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bfb2a5e3sm331906985a.41.2025.03.04.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:11 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 652D8120006A;
	Tue,  4 Mar 2025 22:05:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 04 Mar 2025 22:05:10 -0500
X-ME-Sender: <xms:Zr_HZ8wbXq--XXYslbbNxSkkZNsZ2GNp0gajfIbKWwhTnagViLFghA>
    <xme:Zr_HZwQ6EQghexBNJ_NCy_XUXiyroWQBaVLV4KWENh8h5FtDYKmgLbyMoQsERaFNc
    gCPGsY9uFg533882Q>
X-ME-Received: <xmr:Zr_HZ-WjhdQ2eIlHZQlGRjv_MqUrJXcyitg5QguQSIHwzAx0ZgSZAtJHow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepkefggfevuedtuefhgeetveduudffjeejvdej
    ffettdekgfeujeegvddtuedtfeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepfeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhmlhgruggv
    khesshhushgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdroh
    hrghdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigidruggv
    pdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtg
    hpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvggu
    vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhh
    ihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhn
    rghnuggvshdrohhrgh
X-ME-Proxy: <xmx:Zr_HZ6jyJYC-it1RQ1vHWM6KRbNUjAO_svgO2G93Sli1db6dQNnazA>
    <xmx:Zr_HZ-AFT0fk9hl3lxH-jR1XicCJd9oXRkUXduBH0JGB0SpwmCDW4g>
    <xmx:Zr_HZ7JcU4eenAE7l1N2fVw1g3bCv25xYSXBz4-s-OjQ6S3Zb6I-6g>
    <xmx:Zr_HZ1D1e8ahvlEpSZgU844TsTsP0D7ZalwjCIweHyPzZjDGpMrKxA>
    <xmx:Zr_HZ-wfnm9C1Th2OCSrnxBms7W5hEcu7QuLOTBQbTvKjkT46Y1siCSM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:08 -0500 (EST)
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
Subject: [PATCH rcu 00/10] Miscellaneous RCU changes for v6.15
Date: Tue,  4 Mar 2025 19:04:55 -0800
Message-ID: <20250305030505.94059-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming miscellaneous RCU changes. The changes can also
be found at:

        git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git misc.2025.03.04a

Regards,
Boqun

Paul E. McKenney (6):
  rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for
    tracing
  rcu: Fix get_state_synchronize_rcu_full() GP-start detection
  rcu-tasks: Move RCU Tasks self-tests to core_initcall()
  rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
  context_tracking: Make RCU watch ct_kernel_exit_state() warning
  Flush console log from kernel_power_off()

Uladzislau Rezki (Sony) (3):
  rcutorture: Allow a negative value for nfakewriters
  rcu: Update TREE05.boot to test normal synchronize_rcu()
  rcu: Use _full() API to debug synchronize_rcu()

Zilin Guan (1):
  rcu: Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes()

 include/linux/printk.h                        |  6 ++++
 include/linux/rcupdate.h                      |  6 ----
 include/linux/rcupdate_wait.h                 |  3 ++
 init/main.c                                   |  1 -
 kernel/context_tracking.c                     |  9 +++---
 kernel/printk/printk.c                        |  4 +--
 kernel/rcu/rcu.h                              |  2 +-
 kernel/rcu/rcutorture.c                       | 22 ++++++++++----
 kernel/rcu/tasks.h                            |  5 +++-
 kernel/rcu/tree.c                             | 29 +++++++++++--------
 kernel/rcu/tree_exp.h                         |  6 ++--
 kernel/rcu/tree_nocb.h                        | 20 +++++++++----
 kernel/reboot.c                               |  1 +
 .../rcutorture/configs/rcu/TREE05.boot        |  6 ++++
 14 files changed, 78 insertions(+), 42 deletions(-)

-- 
2.48.1

