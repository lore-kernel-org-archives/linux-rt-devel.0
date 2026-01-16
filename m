Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4ABA45
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521991; cv=pass; b=H42qtuHTPIt+fby+7MOWzvFu5l2J3awECKugTpYzIlcUxgX1LjAni8TvI/Zgx/ngJ+yOJo6xv5V1vVmkK0QkXvsmwpLnOWnjQwSSsln2DSryt2fS1EoGncyhvTlJZDB4kMXEAodXAYmcx5nIUBbyrPHMuKf3L4/MXaU6g2Ydc4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521991; c=relaxed/simple;
	bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKyFEovPiMlZ1K3DtrV5cATclWqnJac2A+7i7g0XO313hr70r7aTMD1DYkrsVr5k4qJPkc39rCIXRqS6tYYqEXhhSo6MRo2/lgwjm9hdo96yHMMZ8Pn7d2o5Y6VjDnyGqcxLUWdifu+8FacATcUqBu6hlfWOOVEOU1GDqE2gYww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fAsA1L2s; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAsA1L2s"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so4129a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 16:06:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768521988; cv=none;
        d=google.com; s=arc-20240605;
        b=ARe+P59j3W3DbZUgCM04sYaeIO3ktunPfWt+MtNeMsFQhSRM9K8Yal2my+6l4rBmNo
         naLpgOUZ8PS6uWBGq/borV+XUdPHlf0ohuRvFMrHiO78W0PCmi5NXuhEe2cUvJrKZt1g
         6tBY5FonR3TRBrRxRG+aHE3kFdkZtos4uxYs39VOG7YuzFrElVoE/UsfB/MOXLj8THqh
         rOUMmYn+ujptTMvD5f9U4mAIf4E3XMGbBLbXxPvDH1vV90WmrOW94BsKnt0KGASyzgx7
         8Luk+D0JsLONzfmV45HWHDDEqao1PaLSNMV8s7DlXeW53DnReKRxPYnkZBqAxWTP3wGg
         Irmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        fh=/0/NT8lViiff8M/+hRNPflQwhmaB8tyJypE9T1lTQu8=;
        b=OZjUMOd4DyprQ9uMREBhMSADEoufOUvFCF1obfjkIBpuqQTgCYo1hgwHsPG9R3gSd5
         Eg/lii1tfLyI3ztmRtFMp106WaKvdGa9s07TPR70tL5jbkSOxw2yTwANoKkbUGqTynCb
         CVn/oqCK9RSnviWleAnffNPF0GnZxE0F02fMR9BVxf/r0uVNw/nHKWfPIpOLVYFk+24A
         qWgwZ60GP/C9ZH247AQfRYzDuuN9nBoeOP15Jal//HCGUuXmFt/KugDS36b+U2hYYMVx
         t3sCYKrqbGuXrTgdPKTSHQyVUxFHYZiRyxnLE1b2VBRNYOKKOLmSod0IbcPcwuMsF93c
         xfGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768521988; x=1769126788; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        b=fAsA1L2sCbM5WalcRTpQQfqEuwCcqKKcs5420aFjXaxJsufQR35icePTwwKj6BWtjz
         ZHPLDyJnF5Glo1taYwllpuVvTB27MjIGpC33y6j61zVDPXnsPPckMsqnJAeXJqkAly5Y
         5jaXPnO/0v48vG1hs+q5amhEzvI3Hn53rZBSQ3g+bFvvD0IQVydeoVPL+ehW7vYlVJqY
         IePlGZy3egP/aPKVcKQ6ucOTG8Gb1fupFaLRU/YFaT4+JXFa1plmACnrrI0Ynk3CrcCJ
         a1GV7sqGS0+mskIsErLfpEgb1plK0OHTslTlxhgREwo7fjBIeC+phRz1oLNCuQYjUITh
         Y/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521988; x=1769126788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        b=ogPCEQFxHT+hYM5PpF4NAQo/NL6mZkSR78qKhVh1kNg9J/HB1MMD95Tpu6p9KUCers
         yUxh3335/uY95QSMEPaUYqzT+wiVv6aGq87NcWhOM/r/xiIA6uODyZMjzJ4JDDsP+5+z
         VR7MuupwOPnalhDG+G2ioO/JiBS1Hm9txUo+k3dTGZhj1FOwW4YevVGKM1T1lCW0kY4r
         T6/lp1W3P7T/3vWlnNscU8S8zrFtsVuuSNeVTT5LRLC40l4J1pmT3siSctIyvVEK/3iQ
         NkLr7DPTCvYLHEa1y3s6+bWR29YRKHFBSFtEQgs1w3Xng/aMkjOoPW0jsEwlNzYwY0A6
         2k5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV65F1dpC/GpOu1++qe6LTdvkWvAg7WkRbeB3qywKGuFe2ok3Gm1B01gPNdzDe94WVvuJKkEAqh8lHjHyp4mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpguZUflIkbD2+biit6FjjL0e8b0t8y+r3bAv6o10Fnm/mQs0N
	fHZEeBHdc2Z2PazuILBTwwzWsDNnQHAZyiAqdJ6vGnyuc8NCBhbqFLlwQ5ihwWkf/VdTvHFX/Af
	rQr7NcezZvwoEV4liSteHUw55mlJDlFyxxlNzStM/
X-Gm-Gg: AY/fxX6eZHEPxRXoWP+JLALVWeh/tZJtD0vzvrwLlKA++PUjoVfmuTykbByV/bJvf8Q
	Z5NbjFPgW4eVdca4Y0WrYIlKAwN7/5R5c1wWrFhQFH82vbRs3v1rXOZ6JbF6+W5pcFcg+lAZpUQ
	dpPIYc19Fg/ksWyj3E6d9QEwnj80WyKCXhOVVDvhRy2TkvOjzx+hV7xPnLlXRQIHXsmd0WMamUJ
	NYT5AN7QsMI1A7ePH56UY26ZUy+cjZlpM35sDBIxRzv09KdZlw8EM6KUScjJUqw8SKVEniwNNtb
	bGKjNZaezq3WbJsNPmKIXOY=
X-Received: by 2002:a05:6402:564a:b0:645:21c1:28f9 with SMTP id
 4fb4d7f45d1cf-655252e133fmr5226a12.17.1768521988035; Thu, 15 Jan 2026
 16:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-2-98225cfb50cf@suse.cz> <aWXvAGA_GqQEJpB4@hyeyoo>
In-Reply-To: <aWXvAGA_GqQEJpB4@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 00:06:15 +0000
X-Gm-Features: AZwV_QiPFAF4oyordk9NHVKA3LxKDdMlmD4Vltq0PHkaKAiIFW6MRACIK30AxWk
Message-ID: <CAJuCfpE7ctb+AYEsmmDbW-3+DU-kDb2ApYWYXRur5FDtPP6zng@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/20] mm/slab: move and refactor __kmem_cache_alias()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Jan 12, 2026 at 04:16:56PM +0100, Vlastimil Babka wrote:
> > Move __kmem_cache_alias() to slab_common.c since it's called by
> > __kmem_cache_create_args() and calls find_mergeable() that both
> > are in this file. We can remove two slab.h declarations and make
> > them static. Instead declare sysfs_slab_alias() from slub.c so
> > that __kmem_cache_alias() can keep caling it.

nit: s/caling/calling

> >
> > Add args parameter to __kmem_cache_alias() and find_mergeable() instead
> > of align and ctor. With that we can also move the checks for usersize
> > and sheaf_capacity there from __kmem_cache_create_args() and make the
> > result more symmetric with slab_unmergeable().
> >
> > No functional changes intended.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> Looks good to me, so:
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon
