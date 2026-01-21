Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2614279F7
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015527; cv=pass; b=oxLSjnpegdl2cgwGqt9ncD2msF28F/4CobERlBk37WcyjCvfbinazzQe7ZJhJU919/xQGf2lDy8aajo3Pgm6rDtelriD9/uLl+EmX0z9ZyKI4OyGreJ0xZRMSDKI3lehslEUqScCkMZb1cIoRe0MVDZimRbpli0EuN7aSdpMHOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015527; c=relaxed/simple;
	bh=G3m/TeF8223oGiWV8LWrSag7Ph7un3ZvTk2MvPdc2eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRT/PdjdK3uyabpr9JAf/m2kEitSGa3fU3wzq/RY1/08Iiou6x8zBGY5XPsx7wIasBEVpHzhPz5+XhL2QNAuXE4gF4k8YtgRIBvJtD86STm5vYf/G3BIdBTPpYjjbVYb4lfGCThvp+YREvlMVB/eYolOUD19nLB2zkGfK4vS7Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGO6z9gR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGO6z9gR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014acad6f2so128791cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 09:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769015525; cv=none;
        d=google.com; s=arc-20240605;
        b=ZLfyYp90Tp4eqAjffWK/tyTIu5zfuze1vwnSykpHNpHGYfmJqItJ1jEkuvO1Y5fvpq
         89RNJvn3SRKKcKt6VKqja8TYCTR65qpeoWuHTEwgj3hogyBlTIGVqdpD3O509cAMKpOG
         ilRB1CzaIfV3ICn6GHO62F8PqJgHzWDBpVlTrycNtDXzLxk0bzspHvZ5Tjb5sTCSfj+P
         f1l+ywwXvpLq+PjmIA+TnGVLOQSj2Hi6+95GllpWJxeeuvmVOsPQeOzeynsjNWNB6kno
         WCFKnqAi0qE+8zd8MwFUGQnVYfKij9CzmgvEdBnegkijvQuw2F9UrP+wu6bClogmu/jW
         0D0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        fh=LDGTZ3xFupLQO1DSP66VEeMI2fqiYDOxiwop4gKqZL0=;
        b=QgtVbZ9poTCAZrYe0LqDyfX27XqbSjGDpVpRvpxIVqUPVHiFb7R+19cmShi4RK6Wpz
         J6rcbe6DsGh/ZpUMaWB1AyzMrb23Ftb42t7DTSV6TIjURhWMv4YwMDxfMXwM9lB+Fz3l
         OzcZg2zq1Mi2IrqEIciWm2JiQJjXVODi/A0HUJF0/EgA1Y5yT+IiJRhc2yu0mpo460TK
         H1bVt2KF7XczMbKMYsvR0lP+9ZHu8V32MIL6y4zwIa5wrm4wWFmWm1bp7adg7AucbD/S
         YPO5+UaJM1Ga6T18csJXrZinAqTh/auhlZZzbSJ4AXp6hRS5+AbkYjvr4Ox2N9f5JfNK
         ujzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769015525; x=1769620325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        b=fGO6z9gRJF31HBHMN5jBkC/2JtzZZDoglSJ/gwz/K/hHtslPe/Ie3aspfYjFsU1nWy
         8c4OhnwvLpXp2k2gjGP4uvbd05XUbPTLKcMkBEJxgq7Bw2Gyw7i2wEgahQiMysEhykWK
         UXrF0MsIboalgDT4XAprUgPl5ZqMpVPkQXeD5LmKx2QGbGLNq2REuh6pSmQlzkktlYTt
         W3o2q9LFmxpDnakJ98FV3wHr9NitMQoiK3TRTfGRsMUPZGRzM/o8MxtifFBD3VLbFSuB
         fyO3yOnHkP78AXYhJkxwH0mmN/0lKFFvuqk3hHlCxMERcJeCpDJiUZcxdkCkS+SGzM3T
         PUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769015525; x=1769620325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wxe8ja7BPp0xudXZUtfCAF8pkuXAFux2AU5rIUV3nM4=;
        b=qmDeedS1b+B6u6mzU8vFgtIIF6VezSfs4WN/I1gQVetBVbU4iM1aiPhROxk4/ueATt
         sNNV1oYKLFu1F0L8bkUDI4AV2JJ10VCdeIiE1Z8Rj6FYhGeQyYRe2ao3dO/U8BVeOwfQ
         6wXV66ecgb1nyf+zpl8RyhfpGFqosGUcJ1Y3emRdRB8xuvbx3ujiSHeFVZOGLogznCIs
         2LeoKaZU+cDX+8WzkQ53SjKGlRYQWWVYhaelLaLT8/6o+s0uQPK9h+p7srpVuGn9V+Nz
         AG3wEG2IqxP7VkpFS9mi7+qoRikWxPLsNGPJD1sQA/lUUlPliHHFvdgt+7Ur2RNAjaaS
         scSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGWIEOCfLLUFiyBb6oPqkzg6QRuvv0xjHkPXwllPtu40cXGefchgdOr3B4F0pOwGcrg29vGQnp1dorb+KFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeuDpyGfsPGdSv22IuX51UwL8G3rFfoSeHZWDIfyQMAEkHcFy6
	H2ODyVGCVBLixLoq0GXPDMA4e9NuVwF06MzGAfMKwCSmhRnPL2UB7mRciJVjup2698oPYpfm02y
	qkT8p8dGVZ3Ji/CujfA1netlonkfwD1td0PSe4e7j
X-Gm-Gg: AZuq6aLQTY1QG4sEZpQNhAgN1d7IZZh3LJFCpICOXkKruvPmqgyvc5fnrKrSsd5lkaR
	N/15DRfXcQJM3nKmzyUoiAJav0tS1FHL9cF3J2xtTr8xryB65+bIM7kBCWIq6XCHFLOy7/e/mQ8
	rvAXm0SqKQIw77mzr1+EUBEIeAEeDntB9eUnS8hXaN7PbwIKGKWfiaBCeGvhEZsecQDFJBQMhj8
	J+xMvOWtgFDbcfd7hIpCqz/mvhYWYkGTzUTaxIvPbA4ch+Pmp8Z7InpPm5/fLKDUjNGMUm3puqu
	H6aWzB+XB4+A1QebCp4qM0g=
X-Received: by 2002:ac8:7e8c:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-502e0c62ce0mr14559311cf.14.1769015518740; Wed, 21 Jan 2026
 09:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-13-5595cb000772@suse.cz> <veqtpod2liqsi4mgcxndgaiyqlhupnymmj4pquueqziqyakmnk@fzympoan5pds>
In-Reply-To: <veqtpod2liqsi4mgcxndgaiyqlhupnymmj4pquueqziqyakmnk@fzympoan5pds>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:11:47 +0000
X-Gm-Features: AZwV_Qi9FJEvRsSrApnNVXPgEwKn9hYifa6IChzrQfzwFnpFd6X3lSwIuICSEss
Message-ID: <CAJuCfpH3DVwK7FqfKb3WChWyz_ZJvECBf57Ehxr7qCzS=Ym_8g@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] slab: remove defer_deactivate_slab()
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 9:35=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:33PM +0100, Vlastimil Babka wrote:
> > There are no more cpu slabs so we don't need their deferred
> > deactivation. The function is now only used from places where we
> > allocate a new slab but then can't spin on node list_lock to put it on
> > the partial list. Instead of the deferred action we can free it directl=
y
> > via __free_slab(), we just need to tell it to use _nolock() freeing of
> > the underlying pages and take care of the accounting.
> >
> > Since free_frozen_pages_nolock() variant does not yet exist for code
> > outside of the page allocator, create it as a trivial wrapper for
> > __free_frozen_pages(..., FPI_TRYLOCK).
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/internal.h   |  1 +
> >  mm/page_alloc.c |  5 +++++
> >  mm/slab.h       |  8 +-------
> >  mm/slub.c       | 56 ++++++++++++++++++++-----------------------------=
-------
> >  4 files changed, 27 insertions(+), 43 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
