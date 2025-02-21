Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F91D5AA1
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157942; cv=none; b=ans6Lvn9wFAKnNqC41tpmrXqUJQxjIOXQ8z+jIsicGk+WdzaiwqEQSHQfz23ONN6CVqnasVzF5OXAQ1x00yy7/5rY4FGLEeKU77k9oqYXe42qQT86W3Uz6Wyxd7+W5d2R+4zmcV9VXL9LyWA3/zuFgfiMlRakUwgxLU9U5GFakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157942; c=relaxed/simple;
	bh=DXvFTs7oxh7lPTo/mbOBZb379NqGajHAFQFN6oblHdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exGmMs6A24S523nj+UFSzecstazCdMcRUkT5fXD5NO/+bqdwIMCOAkFR+/rTQ1WOvukLZ2PbGZukIdKmuOzRYFCmf+k5BpynACNeRmbcuLF1ogvpw3jiR0ZWMf6P005CWfKtQp5AUl7qxkwvN8gjnJyCi8yJpSz/b4yvdjacEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNNrwHcB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNNrwHcB"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4721f53e6ecso17395201cf.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740157939; x=1740762739; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvm0spvO2odf0aHHsM8EDOsI9Ul6jn5O/yToI2VY3kA=;
        b=GNNrwHcBCTaya68DSFaeHLaZlXAo5tlmnghESwLlmMQ4pvSg1EMMvL4C5mYuGMr5Oj
         yUfNw5m5F2fGwN+r9r9pZH+BO2hKNvfgHz3dF+tjaSRtyrw2zzvdsesv5Uafa8Dh+gho
         Q/lf0p32bSBg3hM/SADbMSQxXc/NicdnJBUbx1vTzf6goXq00GvqVeg8YPNG6DXsj5aL
         vkdEzkIb2gTYQzu0KaapvXo3eBe83g+iwEMbtdjObtM15Nf7vPshbGD3z+NzbBpWNV1W
         0IkwK+GsSrbXKs2vSrbZ35F0n0+AEH3X/FwdjI1Ld7UCY/k0P1DsmfA2I5JAdo0jhrM7
         0MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157939; x=1740762739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvm0spvO2odf0aHHsM8EDOsI9Ul6jn5O/yToI2VY3kA=;
        b=nkUEbWpvewZLjNYOegwfEKnKDwHo19xVycXQ+BvH8GRuJwsdd2hHMlMuGuiDWxo73+
         RLguSSHQa5MVYOThXSADSsucVbhT7iaPbW1D07sd7RNhqMzXf4cQP2L0NbkbL3SU1cyr
         2cdiRPJv1iztt+0Z7oep0cxzAhQGXhMsrwshbiKwqPhLlYiC/ltRqt6EP0m3ymHmJRuy
         wECBUt2yI1w5+45dEgzAMD88x68/IUAD8O2Kb+YLPhxVn2L5lcNeRmhi18ZQXAzuDBXb
         Y8R7KqYNkPZlR6jUUeX27o0mhLbYy+MhrhX0tnrl08sZT9xSSLqNBypND7pYUXGOEgDJ
         WULA==
X-Gm-Message-State: AOJu0YyZ0X4UlddVXhEP/Y9wb0u1PedDP08xRbfomew9ZeYEcnAM35x6
	wcMvm29QzVc6i5omVoFOvpuKZ3r6z7XvRIe8KI1t0Em+NN9XV/Xz
X-Gm-Gg: ASbGncvJ3cqsMHviFUC2d8z/4d663H3Z6DRH80Yk2LHRsv6pPr6scPKPwBlkZ4yLgb4
	D2nQHCvC149cjTcR3fqOhbsZTlitPGMkdaTrxBeQn7FoZyQxxM8LrOCiDSliVeKFyviN4a6RRRP
	4ubg2BBH6BGbzwF3H/uA1w2T2pKRA+HUECXdHgcNFoo2flCNdvCqqnmgtr/z7h2Swgb2tdDKscW
	At75u5khJPaDi9/gqpLQSWbpIZAAkX+XYJtqZbCRAI8r9hGW+vnhkZSo1ymuQDTf+5/s0uRA4Ik
	CkXIUADSxDKtV6IxFhmvJLZiy/5TS/JSwN3udWiao8Ia/bK/IWL3rt3er/+4AxBHPF3C1M1f4bA
	cZitLIFDPYDnKyZTm
X-Google-Smtp-Source: AGHT+IFjz6/XWqgrOc/wxviH2i2uUN1ZBOPiZFcPTkpBgZA6YfE7uJZDiS1EyvuQ9fK1Orj1klTwkA==
X-Received: by 2002:ad4:5d65:0:b0:6e6:5d69:ec1d with SMTP id 6a1803df08f44-6e6b01c68e8mr41738656d6.37.1740157939147;
        Fri, 21 Feb 2025 09:12:19 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77959csm100393536d6.21.2025.02.21.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:12:18 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4595B1200072;
	Fri, 21 Feb 2025 12:12:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Feb 2025 12:12:18 -0500
X-ME-Sender: <xms:8rO4Z6mWbzWfFfaAJU5WEWyv2cQTegPlA01SmHrriVIS57agAjVPWA>
    <xme:8rO4Zx0YobszFd7NfkZjlJxxoV41upcDZKRvOHe8YLP_Tae1coEGVZeIhFU-2ypyB
    rAH0T9zwldDOxNSQA>
X-ME-Received: <xmr:8rO4Z4qqXfcQmgtfFkx5lJAzj_ku7Ng3tHAAVVWoLmyZTY160_jNvfmBrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhu
    gidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:8rO4Z-kENaLoP6Mt7t3W8HqQn-L_EmWtF78qvAWnET220bukehqZ8Q>
    <xmx:8rO4Z40xDIS1k8l7MyjBc4-S_rivC3iGQZGlmKdcIbvO71Form3s_w>
    <xmx:8rO4Z1tjmKLHgxkIIi8w7y5cazwit6GC0Z_7qVoWiZggZe379w9yAw>
    <xmx:8rO4Z0Whpxi3WV2K2BmHYsD1tSJIeE0aNdfRNjrskT-vvw6C-bYT2g>
    <xmx:8rO4Zz11kKQHNpbd_BTNJw319ujQCxDK6duhzVTjOcLSvto6ASsKlEDM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:12:17 -0500 (EST)
Date: Fri, 21 Feb 2025 09:12:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Message-ID: <Z7iz8I6QD9Amjfmw@Mac.home>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:18AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
> avoid false positive reports by lockdep that a certain lock has not been
> acquired with disabled interrupts. The user of this macros expects that
> a lock can be acquried without disabling interrupts because the IRQ line
> triggering the interrupt is disabled.
> 
> This triggers a warning on PREEMPT_RT because after
> disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
> with disabled interrupts.
> 
> On PREEMPT_RT there is no difference between spin_lock() and
> spin_lock_irq() so avoiding disabling interrupts in this case works for
> the two remaining callers as of today.
> 
> Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
> Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")

Is this "Fixes" tag accurate? IIUC, the issue only exists after
CONFIG_PREEMPT_RT is introduced from mainline POV. Or we want this to be
backported in older stable kernels predating CONFIG_PREEMPT_RT?

Regards,
Boqun

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/interrupt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 8cd9327e4e78d..a1b1be9bf73b2 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  static inline void disable_irq_nosync_lockdep(unsigned int irq)
>  {
>  	disable_irq_nosync(irq);
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_disable();
>  #endif
>  }
> @@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
>  static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
>  {
>  	disable_irq_nosync(irq);
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_save(*flags);
>  #endif
>  }
> @@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
>  
>  static inline void enable_irq_lockdep(unsigned int irq)
>  {
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_enable();
>  #endif
>  	enable_irq(irq);
> @@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
>  
>  static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
>  {
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_restore(*flags);
>  #endif
>  	enable_irq(irq);
> -- 
> 2.47.2
> 
