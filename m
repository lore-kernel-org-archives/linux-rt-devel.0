Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158309;
	b=CE8c3fXY42IFt38BisxP4xi1zpeBTjvFj32PyghUlGVYFHlHVscjzpaDeC+GaMXbYCYt
	 oZxC3MhcbndwVpHsyGP77MsvhxYvDtULUCHGRnDFBl19VFh57n8Pvf7GN9i4874/2StMG
	 Ayr9eukJTmBJv3hKGRghz6ehs6XU005cAgZd8f1p/jidemWh5vwiLZvFL/sJD/qd9/F7+
	 cUGJVCne05XcqYdEsrGtMpYBlMM1jvoGlM2CK6fGIYIg17d2CnXlgTFWT/1P2qUMXiq51
	 7A9Bp/rC2FjXDAgdZzdFtPt8h+HJAX8rWJ2tYAiiLCy0VGu17rEk5H3e4tfHD5wLPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
	b=fK1hPXObzznkQESa8LhD0e+8ieYHoJ+3yiBo5x+qGaLTiAYqBq65UvHzJJgQf7quCIJn
	 Liab8ur2l1hqEJBbbjcYNn6VdlasRxB1FXiIwlW5KGWsxLaWiAb8ocnMx8cP7km9PXzZs
	 GEPVMJi8olHmj9Oe/7G6I7+9zIo6wJkgXnqxcxTZ3EUn9NtA/SUrVmFUHihY0YIH4nFye
	 GdnLtUlTOmS+rKTFt7byYtkcGkcNLKWlqWAV/+VKNykwkGHuKQm1HQEbYHebl6nwcX4MO
	 yFuz+shb22/etDuvZtLrguFKrAQCHKxQi38tMRsw5TBbREMaw6fxTz+FjtJtruUr5+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLztBbfI;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF203606A326
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF203606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLztBbfI
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b35bso405226f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158307; x=1793763107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
        b=lLztBbfIGaL36LzVPU1Ew9FFjbkJh8PD/DqXXgAmTl7YQ7PM0Ey98j1hUZf12JVqsF
         cgoTfp+MwLOkdyqZpF83Lmal2TsY2tNLMi/tMAnlEKkeDubHBOfpXEu3phN3Her9Oita
         g7QF7rGE3+stcOrIrNSXukQM1+HG7iIWTGbxZeE9RCYZlpVebM3hlUOKSbdWwOmD3b/B
         K/tpe8oGg1F9tBL8BW8dY/Y4NPTxRwaGhJIcrkZ0QYQuphDb+J2iYO6Jcs1v9rQq1ZnD
         M8thEv5UXWPSAjlEJEBGulm0kEEN0ySYryajL0QrFRvBeRI+EDASHrKMOLr7bcRrfr26
         FgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158307; x=1793763107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
        b=0xmVse4qcUfaayM+7QK+rvSDNYoJW4h9UpE9bq/LYSXKDXPPrGpFiryUpH7d8z1S4q
         4xgV720ysrCgFCIGjL1iGSmTzN/lp1CfVzRaXeUwCD18cFQmVPjJmQ5taWtBG2ChTJDo
         CfvHguu4yKImOD4o1na0R/PpLXu0pQWhK6FvklxQGXDGzcHFO0kdWknOmTRd0/f1WU84
         CM5RylSiVr/oZ0pIG/my1vrgO8nn8wzn47ukGy4Rjvq0/8W5JFoQ1HTQ672jkLarPh/h
         C5YFHOA3JGE8K8AiHEvxSRZkabsmHTozIF3tW1RGA3VuxEN+vWAcT9f3l4PiPu7OJmqJ
         oOrA==
X-Forwarded-Encrypted: i=1; AKwUvBz27FH5gJh9YLMJtJQxoP3z/PZjWsf09KYW36edkniXy+bOecyynvtCpKlQKWmwi89LFQ6sT1j9cHJrbcywUg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLBKqOgmwJamdbpVVri8YBSqQILtN4XYhdo0LHDb6b2gV6uI8Xf
	l4VgEQh+y7JievzN/qTPpQPQS39ZTRgEVISdohlQJiBxcpCW2q/1/CBl
X-Gm-Gg: AYBFou1DiBmZ54BdWSWFTrfuyhYqhlFGrDjlIKuj/BEncGW6E8558Gg55Rbdf/wL6zH
	8UByLhAPIpbAsFyyZCF+scN0z2ODIdRDRB4/lR9k8wjZ2JP4QGUBxZDnezn1+n7vHDgQ1Ynvx3i
	ZES96bPgQMo0paFBwlhxE9KctbF11Kq9SVQRFPv8ekMIY047xmt9ojhb7JmdB9P455W/32SnNw4
	/XLgfd7o/lZhh7aA/VHPuCYMZ7+B/1hjLI9SxU8rcWU51Pym14Wsy8mHvaaKq/3bf3XPh0sYYXZ
	e4h2y4mn0MeQ4/RsSe0LIEGz7L830cnsFjKJlOJztXenKjNn9gJCMYWEKVstTGTLlrOHIvJa2KU
	F/Jk8dwjb0X/xyqH541m2CMoh692NXAVIUbozflaBabD8tJ4ov99JahpwXhqkdWMj8MOK0SAqJM
	oWvwhx+iUTzeWmtA9kYXLn388CEdf0aPlydg8nNzVHrgFOdbq6YzWqkGKRZL4dzGAcrCHmoTd8v
	qOdMqWt7/I6aBlMtcLQrK7i46WqaANaIOpCI9WMgYdrkba2M67HDMb43bgt9H7qzUXc9NVX25Xj
	zZl+3aBoaUmfVShqHPD9a6XqNGkMy0NPX6kETBFEHnv98viaQEN7u0b9y+0PCDlD0y8ZNaGk6m2
	58O+YuxLzLOv1ETA27f++BH7CHnUTLEaNkZM1eGpKX34L6ObIjV2W7j1mYVnd+vAOPkv3fDmcA/
	nSJcaF1ADgcvDZq8CoAB5fds7xtm4k8tB9Z91n+ePRYz3K2nhTQEr2RQ==
X-Received: by 2002:a5d:6f13:0:b0:48e:4e00:b737 with SMTP id ffacd0b85a97d-48e5d56d4fdmr2944765f8f.54.1793158307173;
        Tue, 27 Oct 2026 20:31:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 02/13] arm64: percpu: Annotate __kern_my_cpu_offset() as '__always_inline'
Date: Wed, 28 Oct 2026 04:31:16 +0100
Message-Id: <20261028033127.82193-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
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

From: Will Deacon <will@kernel.org>

Allow the use of per-cpu variables from noinstr functions by marking
__kern_my_cpu_offset() as '__always_inline'. This will later be relied
upon to detect stack overflow of the overflow stack from noinstr C code.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
---
 arch/arm64/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 3cc316091d665..105f659bf8061 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -37,7 +37,7 @@ static inline unsigned long __hyp_my_cpu_offset(void)
 		    "mrs " dst ", tpidr_el2",				\
 		       ARM64_HAS_VIRT_HOST_EXTN)
 
-static inline unsigned long __kern_my_cpu_offset(void)
+static __always_inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
 
-- 
2.39.5 (Apple Git-154)
