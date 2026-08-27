Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5E3E00A1
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873496; cv=none; b=dcYZC/JsawPgxQoGez3O/lxSmdLObw2sJlaFbhznNtUzQSSsN/q09AeTqSrA92Mc+Wq9YqH+zQZ2tpdNTbRSjLR4gsrLlnxRxgzK+x8Q8OHm68aZbCkCpHLd1Jr0EMm9fcLcL6+nEyVTMsm9Nh0hqzj++055fKEi4GCopvxVeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873496; c=relaxed/simple;
	bh=IaRhJZseYtmfOAwaHfBsaGhcCpvv3aaACzd/i2DLAGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pbIGjmWNOu1qPyQt79/89JkEIQ9X3fAkEY2XUiIVlaf7TI7WjvGvNQKtU9MtWCepGSLKSr2eSYPVclRgLsR3NJOY/rbaSmvlyOarE9cDjeQkmM0fFD9QGAQ4KLR9c2DPiVQawoig3LA4yjk2P2rFAWwAS43LYEJ3XfnV8x1J+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlzEJEzK; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlzEJEzK"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d55d8cd938so3865005ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873494; x=1788478294; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63v8voqDYPPccdvhHdT2gYF/erUoDbYrARzDm1If6YE=;
        b=KlzEJEzKZb6/bgpdNjlaIyl1YKIdsfC7GmOVUzpoKjPK+NUY5os4m9evvjfejTfzaD
         V0cnZa7QpQfpj5SxyJKHm+Zs60GQ2o8qYKVte53iVIo7ZxM5crSQtOYN5279LoxWbOwl
         Z4VgdWG/v2ZWFPbpHqRq44/KY7d5FhwoCyLBVT/u5frABiloH7jOAk0YbCsuT2yp3KHR
         kN/Mq8RSZIIVimia4yK3+l1J17puwjKjtmLBD1eDPT8p/jZxcDncqA9c5UiAxHpqvBVP
         AANXF1WxPjyLRXR/PVdX3ohTuEBdO9PVoIubO5RzZQCeNvSfwZvb5zvm84dKA/Q5CXGl
         Z9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873494; x=1788478294;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63v8voqDYPPccdvhHdT2gYF/erUoDbYrARzDm1If6YE=;
        b=f/YWwNB735YD16lThhwEanDBmsJbtjIatFybGv0jEp6zkbg7YoFQVX0brh56p+fap4
         z/t/Txrahf13244iPqtgUuRLcthNwaKhlVdUe1X0CP4qzn5RUu9Eg/9N+zlIeZEmNNIj
         YzG6ll+QmQ/lYg/jLNj5LcsH55yg4G+Sa/a19iaolRoPQJoiFWYaKpP6R3ejV0p5ghy6
         2Gfn3INoWkTcNFW5gMV9B40YxBXDRp58qxHY0/0HoYT3JxIKDdg+GyDJmdWEiuHNY0Dn
         QfW5NnnlPEGyByshk4oehXimlms81LHbwCp2rEW8mmn143Bv+YTJA+Vp9kfYJyGIDa7R
         P//Q==
X-Forwarded-Encrypted: i=1; AHgh+RrvKTQNMaIH+orvpx5oH47yMHDo3XWvDwcz0H/kfVPF8ogWmR9jF/9ZQKqiW6NbcwSTcq0LSwc3Smm8yYsetA==@lists.linux.dev
X-Gm-Message-State: AFuF++lwH/sTem9wV4vfDS/tWwcWuMP0QKYeR2s8MmRs2TfRSUjUC/OM
	s9o0MlmaUaO0Xo/TH5BG1W/8/1q/G0UPEfNJA9eUlfxMWeUN+rFnXM6MTtxuasyZyXS0+lAANxu
	6aoKG2pcfLEg8mg==
X-Received: from dybpd7.prod.google.com ([2002:a05:7301:4547:b0:327:dce2:b13c])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1850:b0:2d5:e3ce:3988 with SMTP id d9443c01a7336-2d74dddceebmr49959775ad.11.1787873494176;
 Thu, 27 Aug 2026 16:31:34 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:47 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-10-stevensd@google.com>
Subject: [RFC 09/10] x86: Enable reclaimable stacks
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement top_of_blocked_task_stack() to get the stack pointer out of
a thread_struct and enable HAVE_ARCH_RECLAIMABLE_STACK.

Signed-off-by: David Stevens <stevensd@google.com>
---
 arch/x86/Kconfig                 | 1 +
 arch/x86/include/asm/processor.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..652d5a9c0830 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -211,6 +211,7 @@ config X86
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_USERFAULTFD_MINOR	if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RECLAIMABLE_STACK	if X86_64
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 87b1d4c0727e..207e7adced64 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -690,6 +690,11 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 #define GET_TSC_CTL(adr)	get_tsc_mode((adr))
 #define SET_TSC_CTL(val)	set_tsc_mode((val))
 
+static inline unsigned long top_of_blocked_task_stack(struct thread_struct *thread)
+{
+	return thread->sp;
+}
+
 extern int get_tsc_mode(unsigned long adr);
 extern int set_tsc_mode(unsigned int val);
 
-- 
2.55.0.897.gb25b4bd76c-goog

