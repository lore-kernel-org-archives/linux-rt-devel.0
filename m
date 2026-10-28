Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158321;
	b=FUXDTRO2KrNOmMzf6JBBzubS4RrEMKIKuIcmqGWVGIObA0Oc74w3ZHgyUzch+OThm1pt
	 I8qDAMa4TkS3bZng9q+cLU1Ph6BrXQE0kFQp8m8djk3ncfkRoUxPjFTF7nWnvicXSWYHT
	 B5J42rF/NzEU2pg0DXm2JMcmTyF2YeT5vRMtuMtmSlVbGuAAsT8Q2bEpnBsy8cmVLfbxs
	 1qSAi13EMP5XHyOnMSGS2uBHOySeio7HTy34jXyabLqoK58pY5E1JmGi6aN2LlvOqrnZd
	 RcqZSn9nBHNueTHotngmisWDyjcBuO3NpPcBc59JHtzq5pSciMXGG9VhSYqNVr/bX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
	b=N8K1jvZqd84L5U/yW1EOEshrNfKug7/EKHfzllwOEq7Va/CLLk8m7lhu83uEXLomgmhc
	 9psJ24mFIUeZ99W+yRBIaUohmnqbRuTrNAu0BLVv1dbSc0BqWCaEOEDi2bmQYdaqMghr0
	 5yCREs/VWn7QeuOWLrFSPSaZYTEtzfXALdpw9u3xJxB4gO6ng+KXZDGHGLY6hRVo+EAi3
	 OXP9TGHAoopUg8Wr6aNiqBBGQsyxlS8EM6+JWTKPeKUayOm/J4v115HCfq2LtTDhSG9xj
	 mPZW+TCm90ynEGxbqqX8BJy570VoSZSEIueUr+dciQvvBDYsiczkJYFEJUXfWskeGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ymm2BSUu;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6D606A32F
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D6D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ymm2BSUu
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e46e449e8so289401f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158319; x=1793763119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
        b=Ymm2BSUupf/3E6ePNGH2ckN8OpKc1/2iROPUm/DvCVZ5bGnQQaAGRjzwHFQNsAfG7y
         /AZWG03X2Yzi5VA3kbmPlenjD4l4VnyZXg3WA1MdGpRBVB9LIVIS2IIAbyue1oW10y5F
         Tc3EAdT/g2Dy/aK9sGyq7IiCiDiriGEYChtAovQBFp4VwFT6UE3FEC9qCwuJ62DlUuA0
         gADEtGeYF7+vRf144DsO1uFYYpm+K4+BVc7O60cF+TnyQ/1wAWMJ8y0Nz7WNz+gytKiz
         sdeujyIY+9indj8eN8J48oOWbHoBXZJ0A7BSCnFQW4smnsW3IDvEUtGAo9/mZ0xX129M
         HPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158319; x=1793763119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uboz3++C7Vd9eZqJpqK4o7EY0U6A0LogLMvrqlbwgTM=;
        b=OS3WUMs7C0vx2DRyaJzRutAlfVnEVMQS8tny1nQm37gLTgdCdHrmeG5uy4rHWadzjs
         b3jTGaCsezep/qALDn/ZgZBFp1R1MH7oDxd7ZrS0gz0NAlFgBloXLWN1Mawsj0rlkm7z
         M+rA5WtL10z4jXPyWmZJL15WyWL1RjX1XAx2hLNlpBNEM8fuAMmzjD8muvmb3z8FE2fa
         X52O1UjF7zobgODmgFjvVguZXBJHXni1qJ2TnsxxazmpbyPKc5VLvhB++00EgZ6RBEFO
         I9hdAvmTmdVihqSg2KCaVrm/21RsIccK+8pK7JqM0GEPC8m0ygVrYkWe2wfoCyqaXG+8
         huLg==
X-Forwarded-Encrypted: i=1; AKwUvBxLphnuftZhjmWSbuVtTDyM2F5MOxg006uoCS+MwLXsnNH1TRApczwkKix8WpMPsgF0Ulg7ec8LobKS2jdy5w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvIPl5chBGXXG+Ks5DlP+SwRcCGktXD0MnMNgU9aDrTyQFjaoi
	M//T2cKL/KW/IlphKa6U9fCgHYFcPKYVnA4P7kfYNF8ME9xXs2sISdxE
X-Gm-Gg: AYBFou1sVehRpBDvFHlzzvtmmXlA13Rt05tiIB6MtXSbmoOcd954b0XLYYSiwnnXEax
	hoSe1fUnHIcVr6zuSg1IsoV1ot6xfoxrT7RCX3KHsv1UF+tPLglbNep0BKqyBFGftE4KgiGIs8U
	iccVvtSLMCxdSIoDxUnXCEdnN0q+65FiUiDW1A4IFjQAcggQRKtuO8BcTNTs8Bs0bjOYgRqgewN
	BsCI/MjB7HIAdVV/hCHN9tAxyoQmTTTLaHUjYUbFZJnRq4hMlW9+cz8NMdatIv9/IWToOqtbAPd
	lbMXPt2YxJPV+yOEClwD0TS/rf4foa7TT0K8NckSJhgnoipt13nQV+qaSLK385O8IhV1IRxw5si
	3FAjQNApcyUJ9z2InnQuPt3CT+Asd56BFaI/wKx9aM6EIHB3wiZqYwMw4bGmSyqwwWYRJi40Dol
	K4p+uFhfLgmo3Cz8Hn6D0uGvjU45SqnoFHy70HJePhtJJRvJaKTow9wPjFFYmxrkYjnJtgfbDsh
	nU50Rra8CimYUsSYxbjzr0MOgd64SwrZp8bNtZXbb5JvbSsi3TS4TvjosZD7xRPBKuh/Y7d9XbC
	5BnK1DQU27t2YBWJgJfN/4gciMifnjFUxe4APZtgBXuMuoYjZqYzSOpD9TNGP9E6EkO4lbAUiht
	rr4//8smS3KarrNNtibcDPE+EgGl/1X0+2EWy++wg8tpUC45DPMcB47fBZ2IGCO/LBnMNMlmuBF
	p4Uh1u5mLbOlReKLPnXyfzHeHTGjHaUbSB
X-Received: by 2002:a5d:6f04:0:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e5d2e7526mr2965587f8f.9.1793158319122;
        Tue, 27 Oct 2026 20:31:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 06/13] entry: Skip inactive IRQ-return reschedule calls
Date: Wed, 28 Oct 2026 04:31:20 +0100
Message-Id: <20261028033127.82193-7-kmehltretter@gmail.com>
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

irqentry_exit_to_kernel_mode_preempt() calls the reschedule helper when
preemption is enabled even if the preempt count is nonzero. The helper
returns immediately, but its call and return remain traceable after hardirq
context has been removed.

Check the preempt count in the inline caller and avoid the inactive call.
Keep the existing check in the helper for its other callers. This does not
change whether IRQ return schedules.

Arm64 invokes this caller from noinstr code. Force its preempt_count()
implementation inline so Clang cannot outline the new check into
instrumentable text.

Assisted-by: LLM
---
 arch/arm64/include/asm/preempt.h | 2 +-
 include/linux/irq-entry-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index f3a5c2cd1936d..3e9bcc6e76625 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -7,7 +7,7 @@
 #define PREEMPT_NEED_RESCHED	BIT(32)
 #define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
 
-static inline int preempt_count(void)
+static __always_inline int preempt_count(void)
 {
 	return READ_ONCE(current_thread_info()->preempt.count);
 }
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 289e308d2d46c..e1fd9155410c1 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -503,7 +503,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 	if (regs_irqs_disabled(regs) || state.exit_rcu)
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	if (IS_ENABLED(CONFIG_PREEMPTION) && !preempt_count())
 		irqentry_exit_cond_resched();
 }
 
-- 
2.39.5 (Apple Git-154)

