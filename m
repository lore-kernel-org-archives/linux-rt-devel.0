Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D621DF244
	for <linux-rt-devel@lists.linux.dev>; Mon,  6 Jan 2025 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190845; cv=none; b=g4CxdukVj9jrz5gi2z0J2u7pEqs7SEvT/9CThike6RcJ7XT2eHwnbINOUptW+d8z/4DjMT6ofAva46/44Un8q6trk+kp0Oe6Q/d6n1M4fsp6+vhSb1Xweurg8rR73VdKxb71Ja3gHDZSORrL7wCmMDpBuAaYrxeCgC6WxgtUijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190845; c=relaxed/simple;
	bh=rb7IzNnPb33vb6OF+xVIe3rRRRWnJr851l/gpdvIsJM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=juC9Pw19kX7NiCtMoyYHsGHgSlvWoNAsU5nnUDWYfbjmhCM8pFMp23qFtbMNZ92NAP9XCtNnvaSw/rkQmXBcUPHNS8pl8k6c05Q0SGEci/NB3Yrur54icEUwNg27bZ7o48lqB+cqrWbHV1ovJb0VI/MEDXxGTWFq/igVi5aDv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQYpbqOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQYpbqOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736190842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BFdn8OKI48tlD9a9ioulqWfSY1ZiomBkFHF/k7GC7w=;
	b=KQYpbqOQyJt3z1cziSZWC7v08959SN5kr6Pk6EQ2+O2reNpfGH5LK+JWzlKq9oI+A8Lzct
	SaYxTwRiiqvVaapG9oB2fgq61fYxqgFLdH65WWn4DTRGFoJ72N8ABToP/FDqxu86dehw8l
	JjJpu6f8PMwXw4AhDlCFbiT72vvKMaU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1gEKE5gRMF2nlSAbdXUfCw-1; Mon, 06 Jan 2025 14:14:00 -0500
X-MC-Unique: 1gEKE5gRMF2nlSAbdXUfCw-1
X-Mimecast-MFC-AGG-ID: 1gEKE5gRMF2nlSAbdXUfCw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88d56beb7so148715746d6.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 06 Jan 2025 11:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190840; x=1736795640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BFdn8OKI48tlD9a9ioulqWfSY1ZiomBkFHF/k7GC7w=;
        b=KhKbxmiolpZxR+KhqzNaS36SCkLaR2RMPRtZN7e8u6hwYki8JsCwGvXvSF72fQ6cwj
         l0GqXHl9dIUgY668CCtt+Nr8/sExhASX0WCCir5hrV/AHSgCmplZTCOIXKxUHf+DfoV0
         uX1lwGeZqR55N1CY+a1tXQ1x9ZWmfNwN0X8bZ++dVEAe29daXTb+phgCWfSiDw5YaOeb
         KbA+K1YHLM5yBHNuQaDoRZ82+8RrYRDRXp/1w2odyOJESDS3FoYKbdsq6WPsU33kRnfO
         CdUOzGhje/zLoBJRmLWAb521KD5Qf+nYa2s3Wli33UxvfoFH68aFyEHiUIXSyORwlJjj
         Uu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgqDJLbaqd+1RE/AkNs2IfSaEAZ5N8hK9OWJ7j79C4ds6ncOPyqzCcsAO80Qro20ktdginPRbmkZryGET1bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWzpElLaKNQJ8r/h+xlp8u8I6FCkdQeIvLrGqJURZS8JCWFo9U
	XwU0SrzNb1Z/QPAGOnxShDjhBIAEy2dB+p8tJpBzd70kbE6V2/jA9yRNpM+3ZdUC3JfKziEjZkX
	uogK2NWVqVJzpMXApKc5PVr/1/xdkRThYRo2iImeT/sSegXIQotoHJ1BInSoh5kzg
X-Gm-Gg: ASbGnct7WtA2svwlHmXWaBIMmWZ3u6RaTWcyOtRYGy/fHM46sdt+ZuEmAK16fTVNRrh
	VreDAZ+2iajeD7JAw9+4N+z15eX9MiTJkZHWHbHbw8SCZbI1P7xZymdUOEfLWRDVePrikQrugIh
	RmG1FzsVBGBC1zI0gbGmF2Y2kF7+2r/mpwTUfoYVUYvNqUaejI3sJSgKBvzT1gTm4Y6J1+H1oHK
	sYQDD1O/gmAfYt1SLLZ9tPHd4nJlKu4dknNb5LUg9AxXuRonX+BD1O548XlsUS4qOaYyr/Ef8u5
	ukcfSvACgaJfStmbXhLt9I2j
X-Received: by 2002:a05:6214:20aa:b0:6d8:963e:b4d1 with SMTP id 6a1803df08f44-6dd2332d670mr1066291786d6.18.1736190840405;
        Mon, 06 Jan 2025 11:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV8JVMbJEpqD470qQ9WMIt7T0Gj8y+WTHTQwZNt6c2ki8eC2y4vOMb2ESemoIJsUl1GCoOwQ==
X-Received: by 2002:a05:6214:20aa:b0:6d8:963e:b4d1 with SMTP id 6a1803df08f44-6dd2332d670mr1066291396d6.18.1736190840047;
        Mon, 06 Jan 2025 11:14:00 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d52c2sm172706506d6.113.2025.01.06.11.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 11:13:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f3ca9b15-6365-4639-b93c-33f540448b66@redhat.com>
Date: Mon, 6 Jan 2025 14:13:57 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
To: Ryo Takakura <ryotkkr98@gmail.com>, bigeasy@linutronix.de,
 boqun.feng@gmail.com, clrkwllms@kernel.org, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
 will@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20241227040824.83626-1-ryotkkr98@gmail.com>
In-Reply-To: <20241227040824.83626-1-ryotkkr98@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zivZkQ7ywQ8mS6UV2UN1Y452_R7tDkdaY1_TVA3tWik_1736190840
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/26/24 11:08 PM, Ryo Takakura wrote:
> Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> PREEMPT_RT."), the wait context test for mutex usage within
> "in softirq context" fails as it references @softirq_context.
>
> [    0.184549]   | wait context tests |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184549]                                  | rcu  | raw  | spin |mutex |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
>
> As a fix, add lockdep map for BH disabled section. This fixes the
> issue by letting us catch cases when local_bh_disable() gets called
> with preemption disabled where local_lock doesn't get acquired.
> In the case of "in softirq context" selftest, local_bh_disable() was
> being called with preemption disable as it's early in the boot.
>
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> ---
>
> Hi!
>
> This version fixes the issue by adding lockdep map for BH disabled
> section. Thanks Boqun for the suggestion!
>
> Changes since v1:
> https://lore.kernel.org/lkml/20241202012017.14910-1-ryotkkr98@gmail.com/
>
> - Fix the issue by adding lockdep map for BH disabled section.
>    This let us catch mutex usage within "in softirq context" selftest
>    as it disables BH section.
>
> Also, may I add Boqun as <suggested-by> tag?
>
> ---
>   include/linux/bottom_half.h |  8 ++++++++
>   kernel/softirq.c            | 12 ++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> index fc53e0ad5..f77dc746c 100644
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -4,6 +4,7 @@
>   
>   #include <linux/instruction_pointer.h>
>   #include <linux/preempt.h>
> +#include <linux/lockdep.h>
>   
>   #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
>   extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> @@ -15,8 +16,13 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
>   }
>   #endif
>   
> +#ifdef CONFIG_LOCKDEP
> +extern struct lockdep_map bh_lock_map;
> +#endif
> +
>   static inline void local_bh_disable(void)
>   {
> +	lock_map_acquire_read(&bh_lock_map);
>   	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>   }
>   
> @@ -25,11 +31,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>   
>   static inline void local_bh_enable_ip(unsigned long ip)
>   {
> +	lock_map_release(&bh_lock_map);
>   	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>   }
>   
>   static inline void local_bh_enable(void)
>   {
> +	lock_map_release(&bh_lock_map);
>   	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>   }
>   
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 4dae6ac2e..a8211ba9a 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -1073,3 +1073,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
>   {
>   	return from;
>   }
> +
> +#ifdef CONFIG_LOCKDEP
> +static struct lock_class_key bh_lock_key;
> +struct lockdep_map bh_lock_map = {
> +	.name = "local_bh",
> +	.key = &bh_lock_key,
> +	.wait_type_outer = LD_WAIT_FREE,
> +	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
> +	.lock_type = LD_LOCK_PERCPU,
> +};
> +EXPORT_SYMBOL_GPL(bh_lock_map);
> +#endif

All the locking code use CONFIG_DEBUG_LOCK_ALLOC to determine if 
lockdep_map should be used. Should you also use CONFIG_DEBUG_LOCK_ALLOC 
instead of CONFIG_LOCKDEP to be consistent with the others?

Cheers,
Longman

