Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B43B27E3
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134149; cv=pass; b=uYCthjj71Z19sC1janWIVxhoGXK1mOhmXm8IUqnNQTea8u7ckwFqHRP9V0MNKKUX32EDQH8rwQ3IqRBtGXowiaRtpdgvbKeJqrlsGahy9liCNhLYVXoHPaSb4fLksl+SWb1G4GjqLWCAZRTpNlet//hMDoUHKQeEaZATQJIiUBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134149; c=relaxed/simple;
	bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxNzuRIv1+08YR8guWkAhOQHcaETmYR18GifQPU+XOXA+6FA7f7QidsA+bWXYVzpV7x8RVbaGTtwVossU+xir99q1k39VVY6UCkiJSDKfpKs0eCpBRYbbeenSq4tL4OAa5Un9v0vb8i/JsHG7gmotDfVLEEzF1ay5YMF4Gc2SFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpK0k3/A; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpK0k3/A"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-695469b574eso21349a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 06:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782134146; cv=none;
        d=google.com; s=arc-20260327;
        b=dq+ZCOHcSeq7n/+eh7NtemYMXR2TAgHqAIjVraqdEBNFO0lf0QKPdtgDbZd53NRgiI
         HRu2ckq6mSZoglj236jghSrxb6s35B0t41ORNldQl8P4qcur658otQfBjoshbWw8c7SW
         2yc2fBpVzwALyMuFrLg53CK3NUjCdgXSfbKOg4u1Z9cvFqb4YNKoZN0qOMKBvBiFcRq+
         T4YbE78d9YMH1GcRZVAPMJ0OyzVqwF0XQxNEV1G7F3AoARMVo5hwM2BiOMq3FZRsYuHS
         L0kNhhqs8NZe9ad7T7AQTmy0j6BJlnrfDRNfAJfhh61AZgdcGxJiL9GNc7f2JIrwtmur
         98tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        fh=nM99IIKT/N8yX7Luy3q3X0EkTmMDog/r6Ym3a7geGH8=;
        b=APbod8o/uqYXWXTh+3OuoL4I2V6PNFiZ0g3ho8EGGg9BuAqQcDJkyo05JYFpz1Gdgk
         z/jzzRv+7F57ORoIz2O/U/br92OBmR/DPayvolKV6xk6hSjJniYTPdQfzWHkpO2iHYGa
         lYU0x1+IeKwiu2DebYZON/Vjuyo7kM9dpzm8C3FXSLoajeaBi2EzypJ9OcQw1jwJuUip
         6pA8pUB91JcZqA9CDnrQzZYRaOilo/itbnnGPjrpyGxyt+KSJxSXljYCktb6J8j53Nu2
         BnrXp9sgQsql6Ww78nYt2lDSNy4qombp51l6z2cfbdpmLUrc435b01HoPLsDQyXSma5B
         bf/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782134146; x=1782738946; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        b=VpK0k3/A1f+DBb7bCJHgD/NjLsjZ6TlZ8GkGujvGKJWwGbgRewawWgbRjsd5rr1/1q
         jJRFheMlIRcFAVF/hrLIlUzbymXkLmkV7b7Vrrvsfy/XaAEM2Cm9lssVyrr+iEzCeo9K
         flva+0bSbdCPd+mr23zGAPYobrcgg5rqXkan+WBfdZfqpmD1ChTxV+zXZF6wUAViVMST
         51rktUnu8L75SFfsqCnLpdUZGxl7KpMTu0UiU1GKQCX1iILhUXJBT2PVPCyUvn5FQkju
         zD4WGzMs+K2S1yi9lfY2i/P0LC2K4Hn/fgzRkWCKCw6nLKsRleaxUEEngWVXAe5Yo0Yb
         wxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134146; x=1782738946;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        b=FB/ef02kndGnviXjjzJg818rcsjKTmP/q7EA212YSQxIRqls8/H4FhWPwX2ZMtsYGZ
         T7kcFd50HNpouQemHUNkRYSI1p4lWio/0OJ9qqxyYRWdW4T6aXk1f8vGEqtwrtW5BkU3
         p+0jpAjnC/AingAcrxhZAHQHBYH+s3dmLyUnIxA3ElGqG9hsEDtnSY1vLyKKzF8+OXOT
         D9DLgfns11p6xupuBVaXFOS86uurZrZe3HnXFVeLnnRGcMdN+ugHW7EcOgGZ1eBhMo4Q
         PPi+4aaR4P2qh87ncCtDA7Gem0Bj8yRhIpRxlo8iKFuQEXbp4RGzv8hHzFlL/FqxboYb
         qAvg==
X-Forwarded-Encrypted: i=1; AFNElJ9izvx1FQEiTpac3lyr5VrUYD12JXobeYIH/gbasVGNYoFoeNzxJTgCvGEucTcwDY3SrEh01v4614QdbhIcHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTx75SYApeHCSTYzBeTpts3+mbSg/IbkX6th77ynfzwcn5pIrU
	FZePyE58uxmtWOdgqKb77sD8vy2dZMqy+neveJsAkSqRKWWzJ/XdftDwa64rTO3cthR7T8PwlOu
	nxtGxTe9/v32KQ1/CAAZ/Cwmcd7iOz9RxQLurw6Sp
X-Gm-Gg: AfdE7ck8w4RPol4mE/M0dnt50RxGe+sfrnnoGrKK/tV2PbL//kwutnctnu+Sj+tEKH/
	WGA8iOlvrCAP/5sle5blyLhEH3R/g+GqLVtM65l+5OaZ4Ijg+QRb1LTtTJrqesAhGf1ET7PKZpG
	lencbHYbPJpKrcvhcxiDAdzx9Tx3bx1+xC4KoWEMDj6TreqgVWTU0cx7LYvmZ4EcKOFhoX7gbWp
	dDqnGGSx4flN5d1UDX61xaag1olZ7MR/U5v3rLoWCaKEYTCDLADmwgQR7pguytnbYNQLy7m6Hzz
	GEV7b/4/E6+0dE49Ud6pPJkTPyV9g5q/CPOm
X-Received: by 2002:a05:6402:5154:b0:691:6fb6:dab2 with SMTP id
 4fb4d7f45d1cf-697498d9fb0mr119450a12.5.1782134145476; Mon, 22 Jun 2026
 06:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <ajkzGElCGxJt-s84@lucifer>
In-Reply-To: <ajkzGElCGxJt-s84@lucifer>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 22 Jun 2026 15:15:33 +0200
X-Gm-Features: AVVi8CfrL4Oxj7BVaLIKs0bu_A57lof4blIfUKooVGhj0U4uQfgaPE2LZeA5esM
Message-ID: <CA+i-1C00oZP9U4CBPkq5txH=cP54mypr0sYJU1t7pgis0envQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] mm: Some cleanups for page allocator APIs
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 15:09, Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> Thanks for the series (cleanups are always welcome :) but just a gentle,
> annoying, note to say it's week 2 of the merge window soooo we're not taking
> anything at the moment as it's a quiet period (mm-unstable taking only fixes
> AFAICT).
>
> Though, it's potentially good to get stuff in front of people early, just an FYI
> that we're trying to move towards keeping the merge window preview/RFC-only
> going forwards.
>
> I'm not sure if that'll fix the impossible review load problem (TM), but it at
> least helps keep us sane re: what's actually landing/not.
>
> So Andrew will expect you to resend this after 7.2-rc1 appears!

Sorry as I discovered on [0] I am completely ignorant about merge
windows, etc. Even after that thread it never really occurred to me
that people might not want to receive patches at all when busy trying
to get the rc into shape!

Anyway in this case I'm assuming there will be at least a v3 so I'll
just wait before sending that.

[0]: https://lore.kernel.org/all/DJD12YR8S99G.1I43PSHB77TA2@linux.dev/
