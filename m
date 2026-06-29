Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4D40B36C
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743466; cv=pass; b=oFcIL79U0811X+3uy+mCanQ7nzvIa5SS/mQDTD87c7MltGdnbaEwlnXr+fpVU+mEOA42R7EjpW84DsDCBTt8VCOEybVTUczfCyjNi5EMy8Kg/n77yV1enklkBTmlDVwpU4diCwU0246iY+XUCZ7Ufm+WiDBdy0T+5hsKp5qePso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743466; c=relaxed/simple;
	bh=JOTz4KtAczNQIH2HE0MRXHQ9N5BikOZW0rasYD1FxGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUuOrSimE3XuXAR9HSU9k29C/eSVK7W9EK+Jjix+GATlnjQMkPc9iE5mWiPIqxmdUG8fCuL0AIdL9/SFUI4q0rzEIcYVZaKUFFIbXNBBz4hEK5zUgpebFA9c/K7kRVoKt2UAMP3cIKGKaMF8vxSiQDfTjh54W/9mAlV//L93Mck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYhlXCyG; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYhlXCyG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so13392a12.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782743463; cv=none;
        d=google.com; s=arc-20260327;
        b=dE8tvvvXMMv581FU/J+pLlV0754EwgaFuPD209pBGSu6aHuHISk2MAhg8QJ7xzlOnh
         G/KFFMt94iPlIqLDIIbNC+6B2P804WYKG1TgAc1xS70oxwt32g8mvkxDB3+HJQjSvEmi
         8QxDwCJ+nIJp1jz7Ztbhf6kPz8XTP3HMQQYrikCdqq49iIdYLSbhttberSfexAaYUsCb
         lvbA5CZPzi9yRrfqyoshGYHiS9loPYiL1UfyeOjHn45UfZ2wUyIVo/56Id2W9Gcu6c+v
         xJ4X71jakhKnosVO77TA+owf8NX2mg3IbeKpLlxv17/3LmSRZ4SrJnSkYszwxEtix4YK
         sMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        fh=6WYz3iqrbwQXm/g26B3gV8hiIi5/ORispyz7GXbf3nU=;
        b=pdJzv2kTyfDo1Rqdmn6aXT9l7Tf5MZ4SPVSoRE2NWz0HSoxcg7VE8EzjWNMYA3hUw/
         2xCJFoHzlJOjhFMt86gZbrY6SVEL91c8Qy7ZHAET2Dh7Z3E5ueHNNA1LPFamwI5x5eP8
         2AMKBf0iEaqX6QcfP4cds9loyKQclQ97ASuMQlYnL6DrBH5A0Utvrr+ElESEWu806ySr
         SmgvEj8qV9ruE+0H8+kcBtUm7+/K3RAkFTQChBiX2ba10nwRHLw4iRjakEbODtkSt7Nk
         AIWckloJBrBdHosvvAbhh+cT9VUZbHjlm78VgK3NwIvqRAneWMx1ZcFqI9foPvz6iDVt
         n2gA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782743463; x=1783348263; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        b=HYhlXCyGTdkhrKvpQjjEGczLr7cVPUI5O4gHJ8f/v4qw+WE/M5aqmFA0zNbAOK3tw/
         7ye4XSIm1/d//yOVGQUfULaMPwWCRMVJfnOcr9jEeeJ1tAe6tBOaVmFm4266AcjEFnbZ
         bvrUDu9yV/Cn/EDFfZYW/XnfyO1ZA4HuSApeqsoUdpAg47MTuk1AksD2zrvr7hssZAc1
         CttAzXz1INck7D5T/xZJASx/FezpR+cqT3nnMX2SawpJG/NU1OKhHc2TenJHdsqcu3D+
         Tc+vm6DMRZve3gBzt9MtllEOZEo7l/Cy4aLnsIZ1Z1aFkteRAwSXUnIArxnNlPbB89Ow
         cPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743463; x=1783348263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        b=lp1oBKT22VpdBESfk7gDc4O2NoM0lYxjUwAvFgh3j43CizjC6eLNjcyIoq4Ygpc1U4
         nugiTqFvF0wKh3dNi187vmh8sly5AYWqDgVqBTMZEqvwAknNvPDVI0atGNZeoUwUrWm+
         5/ym7PWrDlE7Unu2sm95vGtwITOUZuUETIH6CxBAuq+mdl0sOqqxMM32l4vpffjP4d05
         sCnyTdkpmJgMWvPAgy7H7VAS16pGoWHYVAp0kmSJfJbnswHtP9C3X8pgE9LgBI0GBmt1
         57PsQ+8UDAGCY0wYxesFDV0JghJ8iTEeiYrm/OUiccxVNhf7EmuEbbgDswVEgCHHkHjE
         49Og==
X-Forwarded-Encrypted: i=1; AHgh+RpRpVBWQqP55eAXhYCOUNVJOvrwaJQnZdKxNoEj6Kjwjx0MydVI40zbJubZvACEu45duIK7DK6pGn8YpBbXhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhw94oIKXMZA1HtFOUtZXIH3S7PQsTfnHZ6bSEghEEKKEftdIr
	Z3HGHrJY2xC9cpfoifjQc4pY2fTT8wQHX8ZjzikL2bj1AT2BRe1WVrKuE70hjqD1YWX9yjK6zZQ
	UxYrChWckvKX7K9SEYZknTdroK1Us2P0l6xNfreRy
X-Gm-Gg: AfdE7cnRrKqKZ2TAMB6oXVbblvHII+zS1URp6ppqaC/04z2lo9RNC2F8rB7hYugnFMI
	A4aZkDRGNaZEKX1WXzIaopA38avvoUGhy85uPJSye3+RxdULgsSFDaLc1j6nagQ773wgMe+tZCU
	pjIlS4QpglBpX6zLXOOLdK0Ku3b0SVnApE6VIlSnwSXZ+Mr6lHbtj1xRI2fcQQITTMc8a2iZ24u
	v42X+NuztY3O4BlnB1bajSHyPkrQSpOY5HglDW9xTiiny4+y0ANaF57IUgd3iRmAKifB60cuw==
X-Received: by 2002:aa7:cfc3:0:b0:693:3e06:8f4d with SMTP id
 4fb4d7f45d1cf-6983f23c5a0mr91050a12.2.1782743462440; Mon, 29 Jun 2026
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com> <akJ6Z2P8eMm1tc65@kernel.org>
In-Reply-To: <akJ6Z2P8eMm1tc65@kernel.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 29 Jun 2026 16:30:51 +0200
X-Gm-Features: AVVi8Cc2-nXLSknBHksHveOm17x8Qt4efvzGWpwSODhQBj5we1EbHkogy0SyKrc
Message-ID: <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
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

On Mon, 29 Jun 2026 at 16:00, Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi Brendan,
>
> On Mon, Jun 29, 2026 at 01:11:49PM +0000, Brendan Jackman wrote:
> >
> > Some tweaks and cleanups for page allocator entrypoint and flags. This
> > is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> > become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> > to be an improvement to the codebase in its own right: unifying code
> > paths, reducing API surface, and removing GFP flags.
> >
> > Tested:
> >
> > - KVM, mm, and BPF selftests in a QEMU VM
> >
> > - kunit.py on x86_64
> >
> > - For the ALLOC_NO_CODETAG bits I just booted a VM and read
> >   /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
> >   kernel crashes in early boot, so I was at least booting code that
> >   depends on this logic.
>
> Heads up before the full kbuild report:
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [v3,00/16] mm: Some cleanups for page allocator APIs
> Patchwork:  https://patchwork.kernel.org/project/linux-mm/list/?series=1118244&state=*
> Matrix:     https://github.com/linux-mm/linux-mm/actions/runs/28375636866

Agh, thanks, I broke the build for CMA.

I thought I had this covered in my local test scripts. I will fix that
first then I'll send a fixup for the patch.
