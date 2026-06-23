Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8372DECDF
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258499; cv=pass; b=POLPPfzP+gW1qVUvEwLbKFhsdWGmcl7c6IojNgnUd2eweqXJuX4a3pGK64dqxx89hiQNcINH4zInNjkrh3YkYtz6Dvz6GMhu/1dP5OLu40HOd0QBw8aPOySKZ7LqBPvjNmruYdG8OJUSHaEnotDgwT+6ATCrUHpXXGQ04tkjdOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258499; c=relaxed/simple;
	bh=CCXbyWw/vyTEutTWD/eCRjOgoZdeOJg2oPH+VOk0xpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZONURBfaT9EHgVGjvo9Qny8cCVvJCalQi5Qu/mADfLU3xQ+cExtud/7Jgp8b2KYTkis9RVw6xP8x0yPMqPf/a+mQLPte82qOtKixgBgkaeB/Q4+1afmrCaYIOhIySL9EsJ3U6jmR/l89bbv/Ua2U61ISDBITffPJqMVfuWQYGSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2lKyugo; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2lKyugo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765531803so99501cf.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 16:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782258496; cv=none;
        d=google.com; s=arc-20260327;
        b=H6bZd/L8TVErM3fGnGf/p+qoKv0RQ8l3kU7tq8rhxbuUynBt03+wmmb3KUt1o7BRKk
         neYbsjueaoQ+YH2gWGNezkftztKKFY3CLxrKV8Hz8l4/pLn+W+cQlUh7J7QNNowpmIVp
         O13D6imsd6L9kYyQlKOMe38bdoDeNusHbIO7kInx64uDaBV/bgtIJsLMsFjHVfJ5KtPZ
         Q7HpimmAZjs6aThii0dawlQabUNxE1Wk0ZtlKNKsLJjtWGcBwwpSNOK2K6thSck1EPAL
         BZf3MVcQl8iqo5n9ipkzYWl4tU87m/dvfmitYVasmzFpuiuWsjzCmOvGRwBePoyHJivB
         8PuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sHhJ3s+79BMlh+EM41yNOzFZl1I5vOhlk0uG1/54xcc=;
        fh=CmQf+zGI64TRpzmH2lHA7W/6py+CT5J6z1BLCEEdrws=;
        b=XWWZM5I+ESe+RqasNUfv7AomX+k0lLh2jPVT1QQTBzgSvvm5Js+MR6l8neqOoYudqs
         Uy5CyQKxjKR8Ycu6Z2bGeKXl5ih0Htt6LGPqWJhp/8S5RZpjNEIjB3JXLu4W+Ik5JAcc
         lBXwddmMR7WTTDYdGT9IKIuNgTT2xYwMxp/r9KfeTl+u/xPmSikkbGf1WGwsnXHbu+z0
         BlTfJdapgBNBPLBmxaB+nC2GS7kCsXeYCWJXO1IBpui3wTZmCqoBMW8i2AhyF+WliE26
         or0vxKv/YkgAdJx6CKy3E7ySYBalCvpzC/NKgX4mQKv8Df/9NRgvLBvy+aamWc0uBK0H
         iKkQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782258496; x=1782863296; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHhJ3s+79BMlh+EM41yNOzFZl1I5vOhlk0uG1/54xcc=;
        b=n2lKyugo3smciW0O1AgnULdknfLM/dKCFooMO25q/MMlri57vlxuIP4HELAhJulQLt
         7deIwGeBxRoRgw8EOaEVGXYrnIKxaDtkgdaceAPf2ILUZiBawz5ibfMd1t9QKk+sR08K
         /VA0Qr+rFegEDsCU6ZEq+07rAd6JQVFVrpRsbgd7xshxoKbapkR1MVipkcSVDSetr5HN
         N28OREv/+kxeOHRMCXDM1fPhUPqUzxuP5+aQSXKSsa9MZybD3CQnxX3iGOcQ58yDnSx4
         rIjJN2cOLHSwbnm1aSPPgH1SA5J6WvRYhs8v70CXR1weay0nW/kyulJm+btHmdX5aXZl
         Q7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258496; x=1782863296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHhJ3s+79BMlh+EM41yNOzFZl1I5vOhlk0uG1/54xcc=;
        b=QheOvdyO28rnvFe2XZzDReNUjSFHyUZ0gCYND+oMSf7RP5eWpFBlGGUHTNmEkQF9Ad
         N55aWfLc5f4al+Ackixac6VdcC5lZy3gZxXOiftODyqZy7Mj5lhofhox1UlGuYKwQtwU
         YARfMimnrQIcre3rJZdsPhSrnAoh51Pr/Q+jSUZoz2D7aiGPI3Cj6a/fyDEypvYw7Vbe
         xkjj6x3UUhnMmon4QxTpqxi0KlOPFWo5QTi/AkUFjyb5NbqHAla6j0rkXnjYiUABsxZQ
         fPE+kCtQ0l+9OQM6LPxRv1rdbZ174gpccGjWI0BwclKIZT7O1KMOudS3HQImZdv/8N66
         NU2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9cJ5hn5v91pe85q6LObPyJVWnQobP0w7HiEjCxXK3UxMpp+7bqSDBkUd1jpev0fUIVyyfcuaBES6xaJbxqGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8gOEc0tJXqZlgmcrkz/sgST1Y7jXOOO9uhGbhRIGyNQn/7+GI
	y/E4FMKOgbZjetLJLQMKIaxGSuI4kS3eB+xFgExaWkBkkjSxkRBzWSJ0pdRwJAYNReuDWGxxUlx
	KlkBqyBQRDHMpaOSwiDaTzThppP263v0s4HSG2o3g
X-Gm-Gg: AfdE7cnzuZatDrq5FHX+lMqRXj34sNyVYrnAL3CZdy1l9FFWObUMsK4gpYYV/5csadA
	5U/FfiuNQFwlzbOmZ4UBPWLuvZwiVwa5bTIzDFuwCRalsUyAy+ebddDFykws+PA9pPYLsKtElNi
	zbBK8uL3Q4eg2A3uD/pDDkJ6ceoklpTJAi2HXGcaOwUpeQtMgd5N6BMabbAZlp45dTiHFR+vOju
	ltWq+LlQNoFtL/ds1Zv8DRqNFDY6VLcHRxbLQuXGhE/GLtfm5JInYA45q9h1+JNHiWUY4c=
X-Received: by 2002:a05:622a:60a:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-51a62873f9fmr1839601cf.7.1782258495776; Tue, 23 Jun 2026
 16:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-11-31f31367d420@google.com> <ajrA4wiAKTdiraEO@lucifer>
In-Reply-To: <ajrA4wiAKTdiraEO@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 23 Jun 2026 16:48:04 -0700
X-Gm-Features: AVVi8CdNsBAUkRPYTNbvvM06_e98li5SHRpWwrVjEcRlly4hSHl5zjPn7Ue86Dw
Message-ID: <CAJuCfpHqvLVnycuufO6Kf3S_RSFjyDRUnTGDyu3VW0kQ90tiHQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] alloc_tag: Move to mm/
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
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
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:29=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Mon, Jun 22, 2026 at 10:01:38AM +0000, Brendan Jackman wrote:
> > This is logically mm code. Moving to mm/ allows access to mm/internal.h
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Sorry to be a pain, but I feel that this change should be dealt with sepa=
rately
> perhaps as a pre-requisite to this series.

I know you have an idea for some cleanup. Let's wait for your patch
and then rebase this series over it. In the meantime I'll start
reviewing the rest.

>
> Thanks, Lorenzo
>
> > ---
> >  MAINTAINERS             | 2 +-
> >  lib/Makefile            | 1 -
> >  mm/Makefile             | 1 +
> >  {lib =3D> mm}/alloc_tag.c | 0
> >  4 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 65bd4328fe056..5d426b79b8fe7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16713,7 +16713,7 @@ S:    Maintained
> >  F:   Documentation/mm/allocation-profiling.rst
> >  F:   include/linux/alloc_tag.h
> >  F:   include/linux/pgalloc_tag.h
> > -F:   lib/alloc_tag.c
> > +F:   mm/alloc_tag.c
> >
> >  MEMORY CONTROLLER DRIVERS
> >  M:   Krzysztof Kozlowski <krzk@kernel.org>
> > diff --git a/lib/Makefile b/lib/Makefile
> > index f33a24bf1c19a..44f6538533a97 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -197,7 +197,6 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) +=
=3D \
> >  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> >
> >  obj-$(CONFIG_CODE_TAGGING) +=3D codetag.o
> > -obj-$(CONFIG_MEM_ALLOC_PROFILING) +=3D alloc_tag.o
> >
> >  lib-$(CONFIG_GENERIC_BUG) +=3D bug.o
> >
> > diff --git a/mm/Makefile b/mm/Makefile
> > index eff9f9e7e061c..4fc713867b9bd 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) +=3D shrinker_debug.o
> >  obj-$(CONFIG_EXECMEM) +=3D execmem.o
> >  obj-$(CONFIG_TMPFS_QUOTA) +=3D shmem_quota.o
> >  obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) +=3D tests/lazy_mmu_mode_kunit.=
o
> > +obj-$(CONFIG_MEM_ALLOC_PROFILING) +=3D alloc_tag.o
> > diff --git a/lib/alloc_tag.c b/mm/alloc_tag.c
> > similarity index 100%
> > rename from lib/alloc_tag.c
> > rename to mm/alloc_tag.c
> >
> > --
> > 2.54.0
> >
