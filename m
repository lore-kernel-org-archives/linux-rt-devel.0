Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C20338902
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584174; cv=pass; b=pD8tSQwIgHVueDSR99R19t77nIBvWsnXXBVG1j5Ke785KxFOSyad0xwOgbjGr3kl4C33CQo7BCC7FdoOk1AYdccNE5kQRWFhchB8xOvOnyr4Hj59Gv0AFluIhAVU5cHwETm17lJUw+7JOxG85rohiwCBpMRoTr3hZ4fQimQ84DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584174; c=relaxed/simple;
	bh=hlDDNKYMaWOnKMiZZysallNw/K6iyHZJPklDuaoHxoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9EIUynikZfUEtWC1545+Duwq2aqFrNstATJ0tDxtv5x2U09cp2kfyQe4p+S4cQ7Lt7nmZ8j9BHqPLdgWA5NeS9PXSwI9SKb7iSgzr/8KSe6O+NcLcuT1AJojZrK3O8Fd9axZL9RA9AjVGmOY05rS4dGWKOOX1XFO6nZC2rRyMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijwBlsdL; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijwBlsdL"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50299648ae9so532091cf.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 09:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768584167; cv=none;
        d=google.com; s=arc-20240605;
        b=iR8Ka151KVZO3u9WGx2SbEF82fJ7yU0OpjKg9iQKENYyY3PWFWbTzggxxX34F+P/ho
         3bU2b0GR/ORtAuLbYj1skxcHdcfZoXnY6Jqy98p0oJo6aSFke/CzdMK+i/bjzPYGT9A6
         IYkT3PSXeMjv7WgZ8rOU/8zDNGHd1z0cqHOulUJrqCfr5kGDMcrYW0x/AeJX6xNeKWg8
         7X2/Bsh/J6JEUG+rB2p4Q8qX+86QAJP6l3d1hIIJCTA9Th5F6JyzZVNav7uFeBlHjAU1
         P935dwREONLoSKjO3SnZpgCU/KVBXbAdTt2vO57UdmJW0hZO94fMPvyjS2DDlueIx17J
         7T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        fh=nzXd1T1ntaKX8Qze7b5AGJP7I5JZ/DyCrrhLN0JNLIw=;
        b=MgeCRYP+TWUJQMlcRzABIUkCgsfBZeQd9ySvET2nikoVUoaS4NyfHgYPXaO9ixWIxX
         aw4OS5q4QhVB0H46VtmkuofgM4r/GA6Kv8bWZAOuWA13ThWK9S96C6ZD0wAcKfyeAExv
         H5bZkqOY7ZAtnamg7Adz7pTQ16ctenA6LdC191rp5DtukBU1xqwHZA4Ff7ArOpJYEh7t
         IqAqwXUMJil4x9sLfZGVHbO5IAZPnHXOejBJsVztDC0GXWGfdGUPWLSzUK1CCfZUD5y5
         3x7jpn0+sKpevIv43pOs7ERo8qeULy9xq4jlvniM+0K8vN+ZnaMbYWpPctdVObs/B/yC
         dO9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768584167; x=1769188967; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        b=ijwBlsdL95jOuD50+D44ARZSL1ttN+5HfK/YsE/ToTWrnoSkOZskZiySsmFHeMZ3Qn
         PULjcON/fR8l4udmhWjYNIkIPtIiQsWlQWeOpOmGnp27kjG1lTcbNcptB3oGccsTEK7V
         KOjRZ4LNeb/K0lfgHD1z8am87sBtZL8M5vYMI9QudY1cwYoGczzPPU4WJ4FyscoN4BSK
         ez8gos2QsI5UbdYgbgiSZk16CvBBGEp3cI9DI5/3lxKyChFqNoPYxptYjLdLSVKPcClO
         /mpwouj4tr4mTC1v/Wuivbau/Yy98WeIpndrt62/m99WT1buup3VA3Ddyq8GPWrelWGa
         /CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584167; x=1769188967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        b=DbkYidYxjL5sm+rH9/TQBOg7Lnxsec05UT610zlQs+eA0ByoJXIJWC01RIQbhk28+Q
         0g+JadGm/CdJxeUCCjxXR1+ElTTaMk8GyrZfvlA5V5yRLoD4gxz/OK+oM1qye83YM+/P
         2J/i0sgD1KeQmBpJ2KoWhXXnvPIqo4QPNrAlQIJ6ixbbuZaeDAqFCIxIynGe13nPls6I
         Asm01HIJ/dAonbjfr1xja0ydBsfJNMBkaSuJc9pMH9Mo+n3hFV9QsAmB34M0UPpBtGQC
         Jwm9rS49vCkd48ruCzc3OShkHlFLVBt/A/NI+pQjPsgjCFcQN72GNZ7wIMbwphwaT8vo
         KvHw==
X-Forwarded-Encrypted: i=1; AJvYcCVD+wpdGlQp/raj3oDZ8wyE11IFJxZl42zCxLj2MDL4g1ALJZ+ABEV0LJq1ClvSxN0MVdkWsW69AVTozVA2Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG/oZscHNdLTm8feIF/BG77ys3QHnQmgXhVK39DxnKGCwOND1T
	msDOKTT+FnyAbd3h7ZLxiNSOyWy5/h0R4IgXvV01940JuUSGNiFU6WWkm+nGrF/zAUuMs1zNc6H
	12/bvvBNVWE/5/mKGJt9hexalTCsOp/rKSdFMkf8C
X-Gm-Gg: AY/fxX5DTfT3SzmxpKW17z1glYySiRRjg93+YL+B6SUPDFegBABobAIGyJE0SDgvs0c
	Ie6Cb8CFCpjuqXYrdO69i4hTizluElW4Z2BZ1oAD6egZED3tkOFnMg8pYCSm6CSxSQsFeWh6QE4
	7RA5Klc0RkBkHcyZIPRzUVE1wdm0FkNRxyJ3KXZjGnUc0adHrKrpiv0yiyT9PYW6rWbvgrRx6ya
	ZyWNG35HLzZy4LOCAs2DGP/jytn+JMCLZW+WmefAtmi3o3xr4iRjAzad8XqyMBf0tkjdQ==
X-Received: by 2002:a05:622a:1446:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-502a22d2091mr4481531cf.6.1768584166336; Fri, 16 Jan 2026
 09:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 09:22:34 -0800
X-Gm-Features: AZwV_Qi0GmjrM2TkwQbQz0K1_wtQP23K0QN4VNJnjVMrHBscdtK49aOG8chDQLg
Message-ID: <CAJuCfpG0SCGf-TOTRi0d8e0Zoh4r5-xXByhnmJRSiyUt9=LO4w@mail.gmail.com>
Subject: Re: [PATCH v3 02/21] slab: add SLAB_CONSISTENCY_CHECKS to SLAB_NEVER_MERGE
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> All the debug flags prevent merging, except SLAB_CONSISTENCY_CHECKS. This
> is suboptimal because this flag (like any debug flags) prevents the
> usage of any fastpaths, and thus affect performance of any aliased
> cache. Also the objects from an aliased cache than the one specified for
> debugging could also interfere with the debugging efforts.
>
> Fix this by adding the whole SLAB_DEBUG_FLAGS collection to
> SLAB_NEVER_MERGE instead of individual debug flags, so it now also
> includes SLAB_CONSISTENCY_CHECKS.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ee994ec7f251..e691ede0e6a8 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -45,9 +45,8 @@ struct kmem_cache *kmem_cache;
>  /*
>   * Set of flags that will prevent slab merging
>   */
> -#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
> -               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE)
> +#define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
> +               SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE)
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
>
> --
> 2.52.0
>
