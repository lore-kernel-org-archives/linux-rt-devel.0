Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73E256C88
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455741; cv=none; b=ePh2WmApZPnRuY2mCjEU4RJz8sAWwsd6wk7azzOJ65YUjNGyF5jvmdJxrkIcmFPpRBdkf/GGT4sJQj8gejQoa5RsuSS/uc+MWu2F1ufRYlZ+d9QmRj+ca5XqaACcdPej4JjOoEzvXmlq7QFT2mU+s3tRBSE8jt/ILjoUvNaW1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455741; c=relaxed/simple;
	bh=hqCPdIph2mEXGKw96mZQH91SjWkRnJXKURdGMWJHfS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDTRydopwFErqA0JmTxllWp0qvKN6vt92j4Sq9AFPEiG4DLkoVLlE8gXKDSUiqRjg4K2I+mxna5+3ae6015rPq/WrkGZXCkWesMkenb1LGr8mC2b6E9WijT8nKFMfNYMHg65V01Kcdb4ANjrLBFDUEUHfNGC+8d3A2Pb20Jmj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2co4NdJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2co4NdJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4721bfdb565so70764741cf.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Feb 2025 19:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455738; x=1741060538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqEV+yYJyqQ0AIRDTVm+hLCdqAfJYbttiuL3CvWulpU=;
        b=k2co4NdJCMQsrN8zTGDVkyVPBYDzVLqwh90BDGMc03OfE2J1TZmuRICpHUhT8L9ZwA
         pWj4zCVjAY0HS2oV7mMfrsRICHm00fUSNvHAnX0uVgcHeWJz4Ehx5YE+QfkSyPIkkZlR
         XswmiYDo8VwV+8yYmzKEQ+j83EV/47dPFBxe8XmmdwZeP5MKjr54EVz5+o7cfHsYN+6l
         w0TGro+Yeowh3qQj4D47fzi4XrIOz+/LyTGo+kFNxjox28xBl3JCVqgTtPYihvwYJKpi
         +VpSKNo/AdT3wEH57Nfnz6HcYzV6VBylEbu8DFp9VkKqJ7fnOiCcuCttXguLmI4fhM1z
         Q+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455738; x=1741060538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqEV+yYJyqQ0AIRDTVm+hLCdqAfJYbttiuL3CvWulpU=;
        b=ofgFCZ6uiCgCCppZL2QB9ZyVXVa5Onf1l81UwZmCvYVDjL3j3kD3SJwYi6VrLe6+Mg
         /BRyUU/7TytmPd+Ap+MoZezAWZVv8DYMtbyVuuEXP7ehvUnTLqlQjZecWBrrbYrSsfHN
         3UUrO2vXT6AMN+B2bcH36GYHIG4Mf2WxqABG3D1TvuzKf+3BjfM8n7tVAHu1eHTnv0J2
         +Rw36ef8CQ2JRLiKtU9wKevijiSiJYDsfwbInsiyZFq1KuI4/DaVCOe8qBJdyrECEa1k
         n0DlQLFnu+m93f675A83WmY+xIhoR70dRiSgSYapCZP/Wz9cqOnsYbAEVQWpOnmJfvLo
         kMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXUXH9IONP1p2PRCcrjPJcZ0/jtGsTuVyn6EBXVTo7LPlVnjnFG9BHI2rJ3PGLE969Utm1dFEi88PHC+8AJfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCv9MtLvMYWbV5E4huIqjp7mG2igtvG+N3MEWt7GEB0PFE2DWC
	myRZ0IYZGrtp/fT/hfVEOEHie2faA9HmOjXA5ddBaL4jI290R8UW
X-Gm-Gg: ASbGncvlruW0+fOm7WxmKdxyorchuxth55Lhbf499+i40+ClvRvabxfD3os5GAzl89b
	gZx93pplFV5OfDKromtilR7W97po5bAB7ckoB8OsPdABV8I0hWmMlabE4x9xokG4VQLs6cmMxP9
	vt9KP3OPs9XUyt3LLVvAxLjbdW1KL0vSS959ACc2na1o2lJXhXx9Kh6ZXjJc5tivdvdxKE/F22+
	Pk0Ax7CFr0R2ywW6tKe46NaDtTMikne4uiuYbY9FBXo0HLpS5ue8RuTXtQcpWVDXj6dEVAbeqJL
	JFKLBIbYE5cmNNAeFEOcaIk0fZM0aiw+J5UO8xDCW1wCj7PRRteRpgbVL8bkZ9q+wJD6Pgz0MiS
	yANxNjnvEeEsDoilP
X-Google-Smtp-Source: AGHT+IEyu+HpjxoL6jLdU8QlNCqQMreXwroF2Gy7vXziN5drHf/L9XWouCuyl5ZeNAVe+tBWLmGsbA==
X-Received: by 2002:ac8:5f8d:0:b0:471:98d7:6f52 with SMTP id d75a77b69052e-473772292c1mr23391531cf.27.1740455737638;
        Mon, 24 Feb 2025 19:55:37 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378093f75sm5077551cf.81.2025.02.24.19.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:37 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54C521200043;
	Mon, 24 Feb 2025 22:55:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 22:55:36 -0500
X-ME-Sender: <xms:OD-9Z4G-iIGQPgLIUNC308rYIvKScu4zjTGGjKSynZq8Hpxa2yFV8A>
    <xme:OD-9ZxUfQ8c-7LhrMf4zK54b2XtltJEjJkxWV-W7YAaEubaDT3870wAkmb_bMMn1J
    JRoSRiHDGkA7rPi-A>
X-ME-Received: <xmr:OD-9ZyJyPfrxZwGZl_FDG_jihsHwUBfqWNmjQtVq_nB6s9S4gjDqNFZhUQ>
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
X-ME-Proxy: <xmx:OD-9Z6GQ77g3i5WnFLJnnmqEkqLobUNH6fpCMLm3LsKrhyji3TQMLQ>
    <xmx:OD-9Z-X-oCjDXsUOrESpioCGcBqvLUuPSMD3pzuV50qKP0rHDMgvmw>
    <xmx:OD-9Z9PhkAMjelULeDfC42W0Qxp_cJeMMRkW3Qu32zQZS71eShQpRg>
    <xmx:OD-9Z11KtUobSBW1fA6fxwiXTcOH1IVOs9Iu398zA2LiXUr0Yt8PIQ>
    <xmx:OD-9Z3UEbeyVbfbgvwUX2RvzLT6KSARuaGCutElgjmr6kLR5TMgWgCJK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:35 -0500 (EST)
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
Subject: [PATCH rcu 11/11] rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y
Date: Mon, 24 Feb 2025 19:55:16 -0800
Message-Id: <20250225035516.26443-12-boqun.feng@gmail.com>
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

This commit tests lazy preemption by causing the TREE07 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d30922d8c883..352393bc5c56 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
-- 
2.39.5 (Apple Git-154)

