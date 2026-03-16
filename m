Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFF39DBE9
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673521; cv=none; b=nmSTV45GX8vCLPr/k6lUb8O30XQkDs6UI7Vr31U61GYslmGOBHPgZ0BjBkdjXpst93SSpfmXhxSwjcXRW6EqywSflpkShcMttOm2Iiw7LoXBn6PzU2aM02Di6co6iar8BJeA5WPCai6fyg4zyQl531ZjletSsnAWY/zQi5yGTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673521; c=relaxed/simple;
	bh=RnzelXQEhcmD1T1EIc3JYmO2mAx5i3ChXWZTRK+KT6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGAxh5WSI9JpRHZIlLMFRbQDrG2ancIEQD0abx0S4TXzD4ko98gtx0fmlyE5xqtdWOOvkyzVybE4c24O19haq4b4kUeXPg9Db5+r4Vnv50wZzm1ddAeE8V/Z8mepvBQxya8hdmhSvuocf3oJuLgOeCYAM3jD5mpYkNRlcOJBlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJPaR/Is; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJPaR/Is"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so26951965e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673518; x=1774278318; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=HJPaR/IsDniU4v2vPku16OdZolh58ht7SsGb7iEH2ZoxbUtk0oO/Mn1n04TFkGSNPa
         lBMuJSLPPf+oN8oH8xOxdTjAj0hs1waRaWknLMoe5xsXGpCxTTWP3kUe1LYB40cXfnFN
         1L2kb6AOzixJkT/WO4dqBMSIVZlM4fvkrRx9pQwrMcjY4An1FAQY9yL5yp60h9lstvyp
         lwyKITdaQqOQ6iTiwhEZFHXxFMN1UvCKy4N8ZkltvRHD7pxQq5OyoLY87LG3pa4r47fm
         Tw0AbafsCEamEaDdljjhM+QMHmgKYsH2+8Ky6RdrzO2He4i86m1yR4lg0enC1wJxNT4l
         GwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673518; x=1774278318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=JwBbfc7Fz5mZHbsVzgher28c6MeN6/fJ5IGr90VJFmRNbLaSzbGkaJeAEppokx2+gP
         7xtxKfu8x0A3uFD3ylHjVsaPmCAdeMY8aUgvJ6vvbcN7P2NgpkQwgQOz8DlG8dSsDtPC
         9ODzTBi/sfcJoZxAe26ISc5BVogShXEs0DLi6NnP1Bdp+WXMEeF1sdatyHfYKae0z9bd
         LTUniw27Ux5eoFtakM7FOMsyWUh7Iz7cm9okTtT7qODAQRM2W3JTAJ7UIgbg2KLacLx6
         YNilZpJZ7m16r7c+d6XfqAMj6+WxL+nyN2o60k0TM0FKma4aFX616DdvgvCRF/98ms6K
         y8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy+E33PMzhrQAuCtyKAI3NsJ6qq38q+rIZFmWq2F9p82mG+nRCUnRzRMcpOzSDuPe4vWWOrBA11NXQKHCzCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+QHJdM/wRHumVkXikU7MBXmlz6n/5VyiPNfbildceHODppGMK
	fdFpBcB0YA4ITBmTIHKSGTmF9r+9aST+SKIDexXA1OCkNyv9ncva1Lyy
X-Gm-Gg: ATEYQzz7JH1vWVV2OG9Mq8yfPOOyfQV3wQARpXUejctZR7LYsDS5EGD/8/3G/UAWDTY
	ZHckXzoc08kPRfWSJlrgsxmrSpXd5qZzzEgxTOudmwyeSbbsX5gWYi1gx2uXSlgdLT1DWAJ13Gq
	eJiFxG85qFm9cemD6djFWR8sh02U3sNMihxeVRds8HJVZuXp6x6uxhdHWOPB9itQx+e/nhjPEPI
	0cVDpQBTsLu6LHwkv76h5pGMvuVJewM1zgxui4xifm93RUi0LpcmaisBIRdcIl0KuHHyHvh8YYc
	014zUrkS9UpcCajiEe3nSDNCxwBM2XQf3yTzE6VHzcU99azLJTnAxFWIOdw1MMv+6Bl30IaxUME
	Hfoa6wP5m5iQ/WBkwDGEUmTb59omav+jn8yBqcGXVNCgS/lDZzkRysYbinick+DnQxbwkgyxS8o
	Up8nZN+D3iznpiIY5ZQ8s5i7moQVZeXk70vZUbputkdMvmLxT96rBVwi5bTUzECsdau1sJor93a
	hRrlUI+PbRyVScGBPUowM6h2Cv1AdYXNjpeVcliIP5tVorDH6bGUv0HwAwj+4qst01N6sVBNkyg
	ye6jqSeIb9w=
X-Received: by 2002:a05:600c:8b2c:b0:485:4bd1:4c7e with SMTP id 5b1f17b1804b1-485567148e8mr223653815e9.33.1773673517657;
        Mon, 16 Mar 2026 08:05:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077fb9a9968087a66.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:77fb:9a99:6808:7a66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm398807025e9.5.2026.03.16.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:05:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:05:14 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Message-ID: <abgcKvuSQc2ZYKw4@mail.gmail.com>
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>

On Sun, Mar 15, 2026 at 12:02:48AM +0800, Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> 
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.
> 
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---

Note there may be something broken with your setup as lore is reporting
that you sent this v3 email three times. Not sure if it could be an
issue.

[...]

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>  
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>  
>  struct bpf_local_storage_map_bucket {
>  	struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);
>  }
>  
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>  	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>  	 * preemptible context. Thus, enforce all storages to use
>  	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +	 *
> +	 * However, kmalloc_nolock would fail on architectures that do not
> +	 * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +	 * bpf_local_storage_alloc would always fail.
>  	 */
>  	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
>  
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &task_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);

I can confirm that this does fix one selftest using
BPF_LOCAL_STORAGE_GET_F_CREATE on riscv64: test_ls_map_kptr_ref1 in
map_kptr. Other tests using BPF_LOCAL_STORAGE_GET_F_CREATE are still
failing so I guess they have other issues.

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

>  }
>  
>  static void task_storage_map_free(struct bpf_map *map)
> 
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> 
> Best regards,
> -- 
> Levi Zim <rsworktech@outlook.com>
> 
> 
> 
