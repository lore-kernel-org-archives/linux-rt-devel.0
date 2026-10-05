Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7054D954B
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226701; cv=none; b=WWMW6WakSPRJRiLDu2R1gtvCQ+mQu0FjzQARHIFWtS9sjG7hC79LDdRlMW3B+JG/yWzvmylEX2UoVXnuwbg6aJo9+pjSmueLNU5VBVz4txrf+JVjUvwFxNfZUdsupPxTQ9vQTIRXBlp6+75GSSFAnG3s6v8YjwTbXmbpIuMg5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226701; c=relaxed/simple;
	bh=kaH16PG0n5qXMp1A+1ketXJJnLdvjaHIZnQlZIlJjfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CW76YethF0XjdxtB+swjkMInErEHAtAP61T9byAUJ9X/V+lCupONcnA/j633wt2Oj/w6xDUV7HnvL5Z1q8+wAYlnkA2qZNvNwrqJKr67CrUGbLWDJtx0HpBa41tAlfYflEoBlxVFl3kHO4sY1i0Wbu9mJUxNhZrcShmdp98FBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjgxsDPC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjgxsDPC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso18170355e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226698; x=1791831498; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrdUODYcC4o3InxGyBh8xP7Mso3oU5634kbBFJDiJnI=;
        b=YjgxsDPCH6B1ebxwbD3VvooHCr1872tlC8hoD2pKGThWDgyA39QYKqnysW1HcqdrR4
         4PBE8pAn0ii/p24y9amEEeXwiEl7CEDOoawwVBxBcPLsp6wFzPyOzNeIttQr8HsJDlUO
         VcZj5pmgkv7exs9CfPwTOXnmihL8a7Fc02nRlqscP1Sg0Mi7/eoHBfOG7JE3aeqeVXC8
         2vO3odpHjujG+Vqvav0pWme2rSnnWfunGtIrbIcpIg4Esfexy+HAezgVlmLBs+O37P+Y
         tZBDw8ld3zXVGdrx5JsNaR+yTwO+y1cj9GdY0eZvSRWJ9GDeUHJUiGsV+NfT8DweS/QD
         v84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226698; x=1791831498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrdUODYcC4o3InxGyBh8xP7Mso3oU5634kbBFJDiJnI=;
        b=0eikogoOQCa+QBUHZ5IXwSmdPK4VXSpabHStARvE9aSypJ4VL/nShfklQlg/jOrb6b
         Ts2FbDcV4YgpZb1wlw4CRb8ndB2kh+0On6J8rtLRPt19WKhDL4l5szP02G7rcENOFwEn
         q5yfhIa6Ux4N1qabScLv2WW9NVfXykmJJE9r7O1vJk0FuiGIEVppqhpAVf6O0+ataKAm
         ABTRINFDbfJtuLnpTUaMbVR03klR/bLh7pvbQseS2Z0kbQrvEqPKIUZj3IS3dJ6ww/k5
         1ywRvpgTQ0TaSr1kRQM7+BTieX9k72TSDPL6UgiJM5G2gyR/hnH9D0VDp9pAoKC0PlUi
         s5yw==
X-Forwarded-Encrypted: i=1; AKwUvByC7MRUsGs5skwk5rg+UX/AhLaBBgEiuAgZR9Xi9oO57+dogTFkyQiUAknXx6dUmhPN2HDxlYFjCHeXFjfWgg==@lists.linux.dev
X-Gm-Message-State: AFuF++n0zyP/XBEUTFdszAWJWJ/+eOnrS+iPPZnAEIM3iEgXxzXn9VKs
	4YWRRg1LeqVh/Bs8x9r8yk1nvK2fzyNc4bwvQqFanlC4iAc0ZkIv0Fvk
X-Gm-Gg: AYBFou0l/OwhgK16eiajE1NAMxD6oa+GporAOUd/SSu03XL4l27csm8xOtsYQEUEYNz
	yQdldaIDr2/sj7EvNetDO54OVZKKTHo/I5a/HrzxMYNd8qU/+JrP3+WxgCArs3ySgxYKypFyixb
	PJtPBmY9W58vDadKVXDBMwQNWy07C5//T40BD/hirA46Aro3i3ELH3PEjGL5ZrMF44YAF8ioMdy
	u++vTa/uCM9oKDZwCgU/6SPqHYhXSPVdMNJafxxR6B39SaFRm+dhCl+mEhyEDlbmozn7BsZITsL
	1LdGz41qYAtrsWKCDwHqFjl97ZDW35CbtdZgVQCkSrnsklJBj9u1jkSNYqEDPuOOIhDWmf4aSU1
	xdPPeDWWsPWEPsbPGgEqUldZLRohIrY2JT6FHKOSJcXFgYH2D03auAFiOaVCO7c9Kwqj2CaYM/o
	ENW7LeuwhXifrTFbipKReu84TjQKqV7gCC2XhAsklBJVIWrkINcNY6WLXW1BhuNwB1iIfftWU8q
	giHVHMG7kKruahx/WzgW+AJTSSJZkfKgVkEhbwJyzmi8OZ8f08VR2PtnjSVrxKVD8row/+YFf+Y
	zEDyhrZEAObHjNvSUA6cWmL+UP8DY4SfMUrzKvd604BSIc5zI31dW6rGLZimvK3k0JZUNLZz1Cx
	Jxg==
X-Received: by 2002:a05:600c:4f43:b0:4a1:79be:c507 with SMTP id 5b1f17b1804b1-4a179bec5ffmr932745e9.27.1791226697815;
        Mon, 05 Oct 2026 11:58:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] kcov: Use unsigned int for kcov_start() mode parameter
Date: Mon,  5 Oct 2026 20:57:58 +0200
Message-Id: <20261005185803.39170-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005185803.39170-1-kmehltretter@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_struct::kcov_mode usually holds an enum kcov_mode value, but it can
also carry flag bits such as KCOV_IN_CTXSW, so the field is unsigned int.

kcov_remote_softirq_stop() passes the saved raw value through
kcov_start()'s enum kcov_mode parameter before kcov_start() stores it
back into the unsigned int field. The parameter type therefore does not
match the values it receives.

Type the parameter unsigned int, like the field and the saved copy. No
functional change.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 35420f0ac524..79dabbad5a38 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -350,7 +350,7 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
 
 static void kcov_start(struct task_struct *t, struct kcov *kcov,
-			unsigned int size, void *area, enum kcov_mode mode,
+			unsigned int size, void *area, unsigned int mode,
 			int sequence)
 {
 	kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
-- 
2.53.0

