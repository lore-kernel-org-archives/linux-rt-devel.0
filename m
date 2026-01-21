Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEC3382F9
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018284; cv=pass; b=IvfkORjxBbL/SzHgglHTj+TkyTC1gEyBM2Z0PGRhSYLrvd4YLWGaQo2icXSClUGRsuAupxLKl99IulybHG7Lcd9vMwVoonQnx3bXmqSaZIaArZt7UkeY4WNSTGETl5lcFMsDyU3qoZuL3FY/mXJK89GQN5PyEOdJfXC87dTNgoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018284; c=relaxed/simple;
	bh=bVBv5qGTZX1JZrmKbht+XHZLieimkBF3AOTYIgjgkp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTV/wf/JV90iYao6iPCq2tmaKCtKL4E0DmMErILLLUKoBRdiT2j62QiiL9P1RXDKsf/4V5iT5zarp4qY32pOaefV9+9DliV/PM3Wq84Zokg1ARFC6yDBQAfFAPM/2JD447Ry9D6dyiIU4a3AZqENHlxZhzTml/m7S+PYFACpHB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcURLIl8; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcURLIl8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501511aa012so13461cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 09:58:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018280; cv=none;
        d=google.com; s=arc-20240605;
        b=cqml7dQ1yInXEmaByQOMPZwDUUm6rKcQ0DH0VAV8bV0fRD3Ux7BnlSt5wbEb/Omwy2
         ZttVgYhQICYcOHaH1lbQTlAlieiAqJJcanEKu5QzgWMdYeKgkR7iUJuUOqyHDmnWG4Vv
         8J6bRxdBYhsglXN0gXrN9WnJOg4OYo/qw1wga1bP86aEgw11x+Ev0kYSdIYoSQs8N7ql
         XSCvSl4E44oH/JgW0+B9JCOciOxWK57cL2jemJGJGwvAWRvWmkn/Q3b8DgfvfgxN4BK9
         M2FDfhU4nSfGiTlltgUV8S54Bv2UQ7cWjjFIJC1Hs2dsPHacS/p7dWy7fm/D738b0JkB
         KJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        fh=bi2OH4kIJ1ijy58rrQLZ58R6iRhmEaJnjCvAaO/d3SI=;
        b=BNu3MynNTDY3voeInSv7TGzC7bKLk2y8pDcH8QC2UnJDdvkzU1as2DMveincJINbWg
         SqiQ7jJbQ8KXEEzshikpLXbMZqejlf2jNKGLFpbPN9PLWKg22048r8xDX/Qgz13z0R0i
         scgnrNUxolS+hpg0bnvESpbwNqPwjl7CLg9Nsj6EA1To+ttxmX1Ro8IZdMqulpOx1y+l
         dhb8GyeWR+j7tCMOD0MY4uWcFCOAxTapoU/rn3vnS9X6GL2+y5v1jlzpSv+Y1zeBtAuq
         Ru/r3Fe8RIGFC79H5c+pQFwP5Aw1dTw5YMAV27AlbZmaP8C0ZpNdDQ00ksrVgWY5TbF2
         JPgA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769018280; x=1769623080; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        b=lcURLIl8G79RyBH2qe+qaeA906CoIKC2dPFn6+I4hBE1sgsDwu3eaIlCiZI0SWuT0Z
         FSUSaXSnRAV8L/zUeH/kVTWB3MutmQwAzwSz/tZPjkgAB57WXiKXkYViyIanidHazzhc
         uod9w7MF3kPKTtNBZ1XFncMK06U+556UdxioT8zysMCktF74lH0BXFUhySUyC85dWMdL
         KtKWb1rj8Z3ENQJHHdWKd14MeCo3Ppt9z6Rj6c2/xpXEKC66ry9DCdypZNZ3vgpcLRAa
         Yt7gprGsqK1hPA8hO4JfbqZ2+5sSHTEEQmPVc8802rTEOalxcuHfpbCfYzGp97pawp8H
         HH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018280; x=1769623080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        b=IDIitcYUV6mDfNk8iVtMCT4Xoo7PFhSHI2T0TJlkSww8gCu+ppuDQHzTqHa5b/UYMf
         rMkk4NBUTKf8JjlAhtJZHJw8utYmM2/28+hnIX75KzYuo+ccJcat4mHBgP4tEkEFbHMh
         Qnx2X/D1XoUYAFDHPluF52uee4SzJrpRvJ85LjNuwdX+e4MjIzQDx1PTx75EueVjYscT
         G2mwNVC3FYC5piYH7BnEeWhxYPCrSd3vcWYK1G+n3mYuUkjrfdfRgHqVh5yIXeO1rfVI
         p8OFgRrZ+p5UpyWIf3VkePiGyOmY/gCfg9M66eOwH7tGUGlWtmLVGGL7X8WYaPy83hrx
         vGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYBqFbGLjyGSbDrSY4ebgN8emI11+FzjAdgSjBlEJrDDM31aD8CpuhHgGVJK7P6hsXaax/8yEwz6doqZNF8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeaxS9JaoNX/DfH0a+IMCB4bSGj5ITpghrPI3rIKNZVPCnwzzA
	TX3N7FMGQFadiAgGwNhm21813Dwugo7JCRyWaf6cVqM2X3KvWNtBQxHew5fvIGyw2lpwRBjdCnp
	OS/nqnhir0bYT/0ghJH7CY/8EIylUUY5N3P4NJsdT
X-Gm-Gg: AZuq6aIsYFQEzbZnYz3UlDU0hlaAkCtBoL4mCxIoCd6/hTV5GS2liuWmpmj0XuGkGcV
	ZsSOI1126iIAlU2poqXYi4ysA/Yn1KKMF/ItnGatn4Wr1nyH7Tnv1Z6oR/bs2M8cxArB1Y5sJEx
	/LAskEazHE249/34YrBRdtHG9MJfVJnraP/IiePe2IZdfK+xZAXU9LfgXgyEETFQRWUz5KUTvD1
	x/a+8p79397neVCj/NCHUgq7XouvrfLOA2/2EZWwUpzYYHX/NIcs4h9+9i8qUbEHv0Beb/AiRgP
	ZaSN9Odc0HCVewL04TcqYu8=
X-Received: by 2002:ac8:7e8c:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-502e0c62ce0mr15215251cf.14.1769018279867; Wed, 21 Jan 2026
 09:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-16-5595cb000772@suse.cz> <v6govsosryla4nzgzbfo3eeiziabn2tdprzhg3zcpoxkxq622f@2ra34j7326mn>
In-Reply-To: <v6govsosryla4nzgzbfo3eeiziabn2tdprzhg3zcpoxkxq622f@2ra34j7326mn>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:57:48 +0000
X-Gm-Features: AZwV_Qj7XuXMulWBwzFRyGRxqGQl3pWQ5GGLctP7N8bmgHrWL6WoILa1XS1waUQ
Message-ID: <CAJuCfpEPX-jjztYVRNX-MzQYdcf9fBrePf0zbhDJFKaEvpcp2w@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] slab: remove unused PREEMPT_RT specific macros
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

On Wed, Jan 21, 2026 at 6:43=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:36PM +0100, Vlastimil Babka wrote:
> > The macros slub_get_cpu_ptr()/slub_put_cpu_ptr() are now unused, remove
> > them. USE_LOCKLESS_FAST_PATH() has lost its true meaning with the code
> > being removed. The only remaining usage is in fact testing whether we
> > can assert irqs disabled, because spin_lock_irqsave() only does that on
> > !RT. Test for CONFIG_PREEMPT_RT instead.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 24 +-----------------------
> >  1 file changed, 1 insertion(+), 23 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
>
