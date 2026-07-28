Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0909222565
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199736; cv=none; b=ihOksRai7cZ0o7gUjU7HWzF0ABiDWbmkBTC3eABo85it+fKHgdWelNhPSPJg5FhhNLTTJ4PT/mIWWnKS9ajpLQ6WlXCaEJrD8B8C3FguYSfu4Qz+et8sEQgP2ZQhXWcZsgwFoLoOEJHVS2VgR0E6kV7PA6PBQBFdbzE3Ndn+A5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199736; c=relaxed/simple;
	bh=Y+LoYAP9VjQ1WH+0mTFVX5LCQoQHjHxfT6/71MrLKcg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hQxbYe+MJ1PfJL22aqDGwVnAwyRYZsOgaADCgDm09TG7ZLKOPGOtI2O0ItxmSjrsGOtM1FUmE+iR1HIDx+0glFVmVXHOOBfD4Ec/mPp5GVzyyHP/GR+FcUik9KZhYVPu6GJr90KZaI7EQXqMtblkdWnm3OBvaIpUCsVHZ9XRkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NtDR7nUg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NtDR7nUg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811f512167so3096086a91.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785199734; x=1785804534; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wAfON367N7TUqFRglbZOr6w2el4iYP2m0VE4AXYueY=;
        b=NtDR7nUgvW5vxaSZH84gTZ0+OStOP8n0q6QVs5Y8DJKS0rtbn5ZP7TiwIFE1WD5mH+
         KSbJGLbnH114zpWRoyeXhcITiEiO8K+oN4a5URshb4VLKnCPtQTsgWk1J4ERuPlRbh8F
         pNRddkGy3vj48/m22B/Q9KW2k5JBxZJnqof89CxWyH0FWWa7Ocwg1YeS7LFsz/ztCP+h
         BU9WJwxh5LnFglUN0WKXizYRZmg5Hn08n5aWjISQ9gqIPn8y8uXYrMCw5ncdr6TjWyrZ
         kvXJwCi7Gru+r+ODdc400J7WoF2d0KPetzCSBx+Ekib7L4niZ6lotMzTf0c2i1byCjAM
         LsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199734; x=1785804534;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wAfON367N7TUqFRglbZOr6w2el4iYP2m0VE4AXYueY=;
        b=A6C/jfhB9OrU0d4kYmLuhhk+LiFNT+S0U0C08OoqGXd2Ww8h/6X4i+qXZx+qn6/+eI
         c0xmrysuJvtcw+yCn+L1b3+ZFQZ6zP3wVuAQKXD5JLMLNwnPTdqBb3dREs7hXTGNZ0JC
         C730M43NIqTWNx/aeGgTkwPvOkL/YxTFRp+EXMA3kG5mrcK6TKoHfc+tHf/0EYhB1Ib4
         tlO3fQVbTRtawmfmQvrqxDw/edVIt3hqLdOGu8aTZofinoYm3TeCt29DDMwW+UiBcglW
         NtgFDBVHZLHypwbVV+3lbTXpUAuQ42fRxZ+eBw++0oxhdGQyf6J9qxRDZKQJcnmrUaZq
         DXyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rortc20JGhM4Q45fMg9w5uTReXaBlmP7yf7TG8/J5Dn/BAC3LzeyyK3rtQ2lMlSbd3WSEAfloH+FffWjXycIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOux8KsD5OGxejGyoyrR7dVjqEC4g2ete5yCjS3nX5sRtPHDJo
	OmEnLKC3ndPBc3OuIFhXYO3yjXEKqRyoaOTz1CI7y6hdIglXdnyCv2/p5M1qfVqDou4=
X-Gm-Gg: AR+sD12LcsXYJFxrsP3vn/VXyiRdTOkmtpISSTF828B2R/FALhC29UN6bGGtdIexk6d
	BQNv7kvvZjbOZbpkFz5WlfuUyIdF7Yx08/tSSgYnBfAKwZDSZccFgcjUU1WKlx5Z5k8wfWSk5J1
	PHjhiikZW+dPS4oDR88PK5QbAL8hS9DejZyYQr4/PDC6oHg56rvwK0Z4BZNCrded5Kj7ZUOwG4e
	SzoUKXEXT1XFForoiU+HJ8x8xqZuGFEt8WCoZL2W864ZCKm8zRMsCjJsryenKjqfrzEpCIPrujJ
	peE2RBy9fkXS+bBPEdZi+AEwDKaL8oPVMbMrmTOBfSY5cWM/UwhszgYMVOD26PBdrQkcqtRZMIw
	zvW3Yaja9vCbAnLroHNyCLPvA0kai1tpuRKIQ9oJEGeWofhd8d8BuVMe63ddSIw4Zhng8eN1mS2
	AwL1KXcyFcxhwMkasjww2IhW9izIcBl9D4iqM7AqsgvQ==
X-Received: by 2002:a17:90a:d888:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38f6a30d87emr171911a91.2.1785199733829;
        Mon, 27 Jul 2026 17:48:53 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6414705bsm478503a91.15.2026.07.27.17.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 17:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 20:48:51 -0400
Message-Id: <DK9SHN2RV21T.485J38W373WQ@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for
 map memory
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260727062521.376231-2-jiayuan.chen@linux.dev>

On Mon Jul 27, 2026 at 2:24 AM EDT, Jiayuan Chen wrote:
> bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> conservative guess for BPF program context that is always false under
> PREEMPT_RT. So even a caller that really is sleepable gets the
> non-blocking allocator, which never reclaims and never engages the OOM
> machinery.
>
> Add bpf_map_alloc_page_sleepable() for callers that know they are
> sleepable. The next patch uses it from the arena page fault handler.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h  |  1 +
>  kernel/bpf/syscall.c | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d9542127dfdf..9ba03622709b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2779,6 +2779,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)=
;
> =20
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **page_array);
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int=
 nid);
>  #ifdef CONFIG_MEMCG
>  void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **=
old_memcg,
>  			 struct mem_cgroup **new_memcg);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d..cec88450e4ce 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
>  		!IS_ENABLED(CONFIG_PREEMPT_RT);
>  }
> =20
> +#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NO=
WARN)
> +
>  static struct page *__bpf_alloc_page(int nid)
>  {
>  	if (!can_alloc_pages())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
> =20
> -	return alloc_pages_node(nid,
> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> -				| __GFP_NOWARN,
> -				0);
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
>  }
> =20
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
> @@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, i=
nt nid,
>  	return ret;
>  }
> =20
> +/*
> + * For callers that know they run in a sleepable context, e.g. a user pa=
ge
> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
> + * program context - notably it is always false on PREEMPT_RT - so going
> + * through bpf_map_alloc_pages() there would needlessly pick the
> + * non-blocking allocator, which never reclaims and never engages the OO=
M
> + * machinery.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int=
 nid)
> +{
> +	might_sleep();
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
> +}
> +
> =20
>  static int btf_field_cmp(const void *a, const void *b)
>  {

