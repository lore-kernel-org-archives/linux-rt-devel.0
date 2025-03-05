Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672D19CC31
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143947; cv=none; b=Ing/yaqBu2MrHIrJg1BNauIzV9WzB0B8Jd/8BRifgTIdgnNbSFyeTmltRsJc6bqW/aZG7J8PRAUi1gdtWQi1e8zEbL0n1nngmOXMaXm3da1ECSavD6O2Av3H4Qe/dc9bSDFdvo9K50n49uT0RR0m9hGcl7eNdWkEUdQw2xv+O84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143947; c=relaxed/simple;
	bh=tmzTUwcDvfcoyJpi6SQQUu4XwTaZg+heQ4riDadkSPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJfgtkM6bYQBplzN1oHD8gGl8SiE5uXQf8PynNRqcQKGYCRJ5dNqYxQbaR7td7EiwdEhCgHMPDwCB2+A6aGNXO6BWl/YGiwdfA7QCX3HoSnYeW0O0mNsKAiDMElOUlCiNvcF5H9zBVu7ZhbovbxgxUxVa9XFRO5nXfRGCCGzsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLx7UTQe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLx7UTQe"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0e135e953so527126485a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143944; x=1741748744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZWUbTmfZeSTAjfInLJsRKj3El0zpw1/MvyJ1JvXIc1U=;
        b=RLx7UTQemu4eVQmcnLdNm/yV/mplWWrbK16BnnkFYrcNPI/Rs27IMdl5wJgWCtz/dl
         /o3U0kCQH83Ml7AtrAuAMdVolXQXqkSlKPHY7xs8zwbr4BDxvOvE8tzUWFLckfbbnGm8
         rkjQbTkdnOFnTgLcB4NA+ItNi9HVp6ecjFjzmpB619BqtUNoaFBtWBPKSRSUZGee9wGI
         MwqQUUf1hbZRfIAOqN5zlt0rnBn0p2BzzSJIhD3+09DhmaRC6IdFZxqFt0NrPH7KFqQT
         WZP3fPqW+SfIcmxEzXpl+kNKOkBeKdWp56Be3LJWZXreuWFf4G7JNOxW+ioHSL76TxH1
         t3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143944; x=1741748744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWUbTmfZeSTAjfInLJsRKj3El0zpw1/MvyJ1JvXIc1U=;
        b=YDiHcD4qJuFPfALGCszckSvoNiqnLuHxKv2BA4bX3TxThlyB0pOQ5BmJusCz8FUPuf
         D/BBtRV9kBQu7ITL+H0UVITvcB4V6b/b1a0CfrGaXiR+dVnLETgMmpziAK+3hZ/pWEEG
         3MYlEArmCsbWkMZa2Ytcyr6lnP42biiOu6+Ac3LOcA2aMbtSE/7dHImmBtVZ7VeffB6m
         1Vh3Aja0XFKOXrTLTM1Y2kP0p9/Cfr8otrb7N5LvlBhBY0mBf3rvTjsV5oI9QvIvaj9v
         YCHS2O4dsuC9qZB6UBBfNlko2l7+EExO0prTs9y0XzN69bhZloW4qQnAFi38nkQa30/r
         jmug==
X-Forwarded-Encrypted: i=1; AJvYcCV83gRiSn6Rd5gX7CzNui0rh3NfUImmQNtIRd3URAN7WoCNM0nmTYOMnYppWQe19qBu5yiz68hFx+EYLMvD6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEVKbXdHeopxDyu8H0BH02pEXANbjNimn8R9BNBRnnSd2jU5ey
	HtKO6por3R/WQsrAtuLcT/R/Py3qMIffqCdn0vu7vvHmK9HgshkL
X-Gm-Gg: ASbGncu1wm8VWJW71sHeeXmUmvinchm3odD1haIHeDJ32HLn30jH/3bMiiV5j8zIjtd
	1N/oJUTb4w1CAu7eK3fsMOsQ7UsywVHr6cgcZIej0JOWG/chDC45nLsNsuybc7dvAssgf6y1+LE
	XI/7OpoUPyTWMqOzuInZT47OTsdDpVvC6jDrukNgRCcl1T7SYRX2O4UkFXou8e2q5fivYdpwZbQ
	q0grICBKpNpMn+Qh9vMop6LC70xSJffNxcgbUSlVHUfPlm0BMAn8PvC6+FXXQx8tyxOZlJtBfxY
	JEdtdvk/05W3zTx15ivTZ9b2dqGpQY2Rpuf3Egf7zXD1z5ufNUovPJZctEVunOqON5j4BB7DPQT
	FR3W1A5AKoOmtZvuT+Bn2jh7FjosqkRNzwEQ=
X-Google-Smtp-Source: AGHT+IGbpMYWPfZVn/GZecxLR58PtHpyaPX50Ibx/nZVKroR/TmXFshuqFOaLzZeECRWUFdnxpEcCA==
X-Received: by 2002:a05:622a:1389:b0:471:ef27:a314 with SMTP id d75a77b69052e-4750b442bafmr21764871cf.18.1741143943723;
        Tue, 04 Mar 2025 19:05:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e3affc66sm38282841cf.4.2025.03.04.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:43 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97BEF120006C;
	Tue,  4 Mar 2025 22:05:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 04 Mar 2025 22:05:42 -0500
X-ME-Sender: <xms:hr_HZzVCp4811y1v0HMNE_DtrqokZWSdaDFbovUtWwaERI2lu0Aq4Q>
    <xme:hr_HZ7nqhLbFnarche3oZknQ6XfgFb7KrnZd6ncqcdRJ7FGK_KIXlVNHH1iGrASeF
    GQWKoPQ9BK-M_zocg>
X-ME-Received: <xmr:hr_HZ_Z-Zumty-cK5DUOI51o9ch5ijm1kpdkpk-PbWHDfDowJaFBEuy6zQ>
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
X-ME-Proxy: <xmx:hr_HZ-V-YBozAK7CCv8OxamG-SRbo5G15qpPCTYu4D9taV01LIDD6g>
    <xmx:hr_HZ9mJd7oxi4FK58Ax757qYdoqz4-06OfOi7t-hK3sXm-GFV4iQA>
    <xmx:hr_HZ7dDsY1vyGHFINXzWx92JYLFx8XN55FOhLYkfWClvMcUPRb9iQ>
    <xmx:hr_HZ3HQoSgxVXQpi0-j-6QNgesuJC1i_0KriWtVJI5OBaaesmne6Q>
    <xmx:hr_HZ_kSCN3Axlt1Ye46jHGuLLDHmwIStdSvnRj_-BNEeWxlziVot4bQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:41 -0500 (EST)
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
Subject: [PATCH rcu 09/10] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Tue,  4 Mar 2025 19:05:04 -0800
Message-ID: <20250305030505.94059-10-boqun.feng@gmail.com>
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

Add extra parameters for rcutorture module. One is the "nfakewriters"
which is set -1. There will be created number of test-kthreads which
correspond to number of CPUs in a test system. Those threads randomly
invoke synchronize_rcu() call.

Apart of that "rcu_normal" is set to 1, because it is specifically for
a normal synchronize_rcu() testing, also a newly added parameter which
is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
with other callbacks in a system.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/r/20250227131613.52683-2-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c419cac233ee..54f5c9053474 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcupdate.rcu_self_test=1
+
+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
-- 
2.48.1

