Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582376;
	b=l0t5fvuMgwI0xxk3ZShFo/y9BEftqb14E13nB4k+lPM+8P/RbutaGulpgkjoBZE8IZ1U
	 6wdm2G1W/M41w8LcYUy2u7vd4hCcl31x8ENejzMKp2RaxrDfHK7/ko6VCSd7DPItEiA6L
	 mhbHu4rBr3Kyq0pRCxTgoPLlpXxZVeWSbOVoN9Ziab4ICsU3+yRICLS99ueVmAipb39IT
	 qku50+Hr7Ork3ZDEJIKigy7az8feMj/KBZn5yyoQir2T1B9rysj+XImHOkFKmhsvHTESL
	 e+AdJxjyrA+i/waN/LF721gYSfVm8csDvMD3LpHpvKp5FVoQvuJLetuxW2j3N7jKU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i696Qr9U2GcHUK/UnqEEL6xoYz649l6h3FsqJ59+e8g=;
	b=PGmrlT9Ol1bKogrhIVA24t8nzz2vFX4jT5TtiqNL7rXMPAlnN8ye0jPC1cR3l7vfWknF
	 0RuiGtr7lKg0Cb6iwRzf3F67ugkFdMmO1rVtKnuKAkabDI+mrJK9+9f8QhEwPmhSs8VSJ
	 kLA9Vy0tjTXCQgMoDtkkeFSzeO5MUxI5PiHyYLg82XPim1wJF2CMrNQRWBswkQLgiAf6s
	 FrDDMXLenpt9L1rjvBMfQCcTp/l5RDy4UXliFsjm/qX0xrNx1GhPLStc3k75wlvJYLRim
	 eO1b5ObuXjGuGfWa/0ukLT3tRqEYvTJm2uuvZan3Ynl4zrIoYUtFJmOnSNUxcQCex1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jmtu9mWm;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF660A2619
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DF660A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jmtu9mWm
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso7587845e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582374; x=1795187174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i696Qr9U2GcHUK/UnqEEL6xoYz649l6h3FsqJ59+e8g=;
        b=Jmtu9mWmukt/wFiim/vqNWtFXZmm+VYTRfssuzSkHuSSznZY48gjTHOiQIZKbqtVtm
         c+SsJdz2s97CkOkvy4t95ltcGrtJ1o9oQIgI+nKaEXuKaCwPlmMO2fgMT26ohvby4KpD
         tXkuKQJg4fuiYnwKDlso2u2hR2Mr8fIZq4XSKhQQhtz1doXUXCOkct/XxRsD69D7UeMT
         JdkZrDxOTZjNJb01bQazcV1AQWFsE18s5QopLNo/ijZbTEo0JHy9THsrwW9T9HHw0wA1
         M5hMv3ixPFYJzPIxyadeMlZFhLlNWdxrFGuCLGqZrrn1NRyNy+50/K0TnopbNDusDDtg
         FPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582374; x=1795187174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i696Qr9U2GcHUK/UnqEEL6xoYz649l6h3FsqJ59+e8g=;
        b=TU7MaFwN2XRUIsOt9s4zsEeseOq4BxbihTL+a/7ZpY80zeZpawtgaNMQrSE7M1Wwuj
         xlRqKfcSYzXsWV9sDl/ozQKDi1To+wYzGo8WkWnsYmdJQeX7QHB3tjHPMOOMZwz1adbU
         02az5lP+i22CqCo1PKEy9Z4N9+TA3O08VXm1LUc9ueqF+yVU3Do53MlzyGFg3IlF4pg0
         r7uaE34ALI6QkORktBvqORviwuCvSdV3D8fGHRiZhEX3/hRaAxzKfwMraj/M4+b+HFVv
         0uARtOrb5Mz77GRkukRKKFbxAazjGE9RFFS7GOhPMIfAFeLsSoqx41p/5Wka0WN9Xmf8
         ofSA==
X-Forwarded-Encrypted: i=1; AL+hErG0ZjG5ClgoydhB0Ax8v+k6NMa/ASiwLTLnquB6bjV2jiLPUg17vwW9r3GH0zbttScUVjKB29z26/tYEXYj3w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eJVL2iTqE8z8A/oE65P4Jyvj9F7F0Ya55sh+194kWnYhZVDM3
	E2Rd2tddcX6y9bh6EuVE2v1cFP++ZYUR7hDWzK0VgRV+cGGYDLO2Mn+m
X-Gm-Gg: AYBFou2ZvxTYZz2m4XMHzJsRp4BGPYMROqVuqyFms1EowFbqWoO1ljHrt12EDGHc/QX
	PVClL8OBWIkzaXBNFIcvxWJaXsaoeqgPDgLfizETwIU+ny8cXUhArbGYksLf8Yx4XoYgzx118zq
	or5/qeyKYdcvkNU2VRrIKNb2WKZ9Pmy4jROu9uvd2tCdaQKwlX+kUZr8cDKIp/sgEQDQZIloqpK
	EtGBvRrfWM5FxOPINHULG7WpPVb3IBEx71qMBoDADgo1tOXih45CCvjh/8cvhQntAi28IXs/Hsq
	uqmD0H6MTCwrSaRpXGsapE0ge22ACnsnqf347a79kkqDoeGmIiK9x4aLpumvzPq5o0iPIA+7Kg3
	LNw+x6gcLKzxPp1HilqX6TkFdGFHD1P4EVg+EAWOgNPzC6BdjhxB4M7ZEBk/EMgMr2j3f9OCEiw
	yMf3gAAM+9Eqy1iRactW1gGhc7xreRNmfK6NbzmicjlCgDbXXgnqUfOvPEnqt+IfEDzkNfysirQ
	/TabB2Awmik3dURQY3OaiU2CxBAs9u80EfUiBSnvq0ysprmlH6iuKXmLViIZI2drNXhgZCpG9KM
	lRZprPzPY5I7ETrHjDWSD8NxHhHTzq9Q92iwOj3qIq9PAwaG/80sDZU4jd1yV13b33gOECac1mZ
	vOw==
X-Received: by 2002:a05:600c:1c28:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4bb55a812dbmr68819625e9.27.1794582374202;
        Fri, 13 Nov 2026 07:06:14 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm44176485e9.0.2026.11.13.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:06:13 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dario Faggioli <raistlin@linux.it>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/deadline: Check SCHED_DEADLINE affinity under the rq lock
Date: Fri, 13 Nov 2026 16:06:07 +0100
Message-ID: <20261113150608.9233-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105164856.29698-1-parri.andrea@gmail.com>
References: <20261105164856.29698-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 05:48:43PM +0100, Andrea Parri wrote:

[...]

Gentle ping.  Juri, Sebastian, any comments on this one?

Mathieu's v5 [1] touches the same code; I replied about the overlap
on his patch 18 [2].

[1] https://lore.kernel.org/20261108185406.1549770-1-mathieu.desnoyers@efficios.com/
[2] https://lore.kernel.org/20261108185406.1549770-19-mathieu.desnoyers@efficios.com/

Thanks,
  Andrea
