Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D41A9FB0
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189476; cv=pass; b=gKBbfpk6hwaL50HfGHemHP5H3NQ0XWi2VKGJgiVucy5se/gWM7bkynTqy3bA/6fOHPEh8If2ue8CB5GCdb7Q8EJnFN+1zAS/Q4/XqGcXZMFuzanBnhPVYewonWZ0yQE/9ZIaqIeSj6WLoCVI17crvV4l7Gf/0f5T/jjeUQUzU50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189476; c=relaxed/simple;
	bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTaVUDXCZS6XHMprCz3A10wXSWyke5dLBsFfTERGXIIhicUB6QtKpe6bAoKetW+lmaosB3EIPXsLULEgkMA3VYCOlHdp8ulEgpNgbSKJU7yVJ2yN2VlJ3aPUF4JGnIaeV48Iq0TU20frN1jaoKnO909BOTFVOgZsznq0w9fcqvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmprUBUL; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmprUBUL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43590777e22so1504146f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 09:31:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769189474; cv=none;
        d=google.com; s=arc-20240605;
        b=SSg+eIyShcgvVu1Si7mFywh5G1IZ9lohYJvhIz9+oh4l8/spHgc+SlGIaj4QlQjLRD
         jxzU2ycWMBf9gkKFLR8ZWlEp7Uag5deQOA+p3rX8E5C+lvYi+mimpX6+SfwjlKEBBCh5
         2e3nKvOqWw3OXqTImThQdda3ifrXSgq/6IvPLsrKgPB/8nln8PzFCMqkclOqE4FYqt8w
         oVgRoUbpwbA1dyL9EIIRjblJCIXj+TjuYoz4RnikaaqG4/TDYjvKndrDQe/Bq6Djf8we
         6DaJgR5SvgPXlaE6BFP3ykRACJhdnLUxsheUZ8l/gwLU2CWtw1KeNvm29A7XcRFpXUsr
         ixmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        fh=ufdfdQArDoppnbHBAhBY8bopLhOZtu0JT+aUP+vqS6g=;
        b=arfdGKDhDm2CagO1agAuU9Nwwk1/OnSBF/s9CQE5bPIUXc1dUuWZqc6Zq/+nrZetvG
         Uo5Q914qXVhu1cwETu+eIG4scQOl4X2JNp6V/djQ+xhQCKHtoM6nBU/0eXZ3qPiBVEw7
         XG9P/Z0JTFibptpjTKb2rMd9kzTt1Ypuq6UYCf1Vpq3kW+GOYJgcyWrtiQ+HqTxVUcxs
         uqFBdN4vKLHY8NvIvlYwyEbRUrq8dRZqFMm8nZqXGxREL0XmvF1MGHxzqdbtwfPqxBUF
         7/dKf2Y9+w/arkmUmk+uKiHZNKPHxKcKjwTdN9EtZCM4ViwydUJA6tc4hs8cY9GaX1oy
         O8yQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769189474; x=1769794274; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        b=FmprUBULSXXzfxQVl+zeQqzK1ljrqnxgx8sdmde6wTDkU8EMz5DVhBM8EdyMiaOruX
         HRwBvrICdCd6a9YA81LX1/761PbxMogQCMxjIispHVfoiGeNG1IHjKFSKHpHUr9zqc2N
         Zbo/h2AVUJNmGw3WLPI6E7I6zM0q4dbSXFq+duWpFoUDGOoYoICjt6l9tBFQOrWT9CXQ
         X6Et1ft096vHpb2JDZRZGRCUd2+ypbdefXCd9Zt+ih08YSdFcCdYhTboBurkqZ7w+gn+
         ekiGhOvt7ptcE6+8fV6CW9S5P95BH5etur6Gc/AYWMWJoYmba1mNM3wFJ41fGwhROhfo
         U9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189474; x=1769794274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        b=jE2AKiHj6Lh0KLhW49Z78HgnKDwokX6DWCQ1wd4dOaBUB90FM4mi+sCvoll4kNpdu8
         TSPGDyxdwIIaz7UQFD8OU887a18hfyvN/IWIwIywL1Z3ZrcB8NEdid4VMLIdgjjVGOzX
         u2EMneYtuOwzEAF6p0R+aW3eYTLIpNpG3A9x1zfCCmrMgPjU0ACwU+rLcVT6ibUxbLM7
         r88Nw5isnhgdQi6W2J7Ig8IgrEf8Vn6GkjlD3HJ611psjdbRFIpJHwlSZ2oEUGAY9f0W
         BOP/sSQ/i/qOwY4l4GWXsViUS5ApMycIlRNNQiZFjDsD2Tq9HgOcOrdSHnHRixT/velN
         0zXg==
X-Forwarded-Encrypted: i=1; AJvYcCWwBdeVdvPPhBxc9LH94gD8sVPMz0DxvYHBXni4xKebNvYp8mguhngjaEiG8zHzW15A4E4UZa/8vSWMfMFhnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVy2b6h55TR38YAz8oKOC3X9hVFJlnuw/BOqUe5TYTJuQvNR5o
	OCkYvP/n8gCgWCnrX9xDb7oUYOkmraV94m7SoHpNRPuct8y1DZeaBmEF1k0EOPNtCYXjghIASlX
	n2UC5Q01clgQvJL+KZlLrxhRMl42GRvU=
X-Gm-Gg: AZuq6aI7Vb6JHZTqv779MOoyQQsbisqy6WrxmbfpWwi4d8gZPBmsZUKSqhE7EEbTcEk
	LPmsmVK8SvppcecdlveMzGdjKpurZX0DMUuXmwvy1BPKaHI/u+Cg0uKx2iAkrT8jnH8Eq3fctc7
	o9PCksSuwV+zlUTvell2QaIT04yUipXM7iLvM4myaBWczsY+fzAYGuVJrh5vxPlxaBMKvxfLeDZ
	bmP0FOjrry6foetaLYVTUZht9oRM752hCqul9WTBGNunDVY6LFmxwwYxxQ/uFULg3h30L4Wo9XR
	6TUAjvn3sUwQZmadpB21BkyYkicFC8xDPqmCS5yRQaTqbKcK2R6+QLRiXE3WPOB8USOp5bH5
X-Received: by 2002:a05:6000:2dc4:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-435b16280damr6748411f8f.56.1769189473665; Fri, 23 Jan 2026
 09:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-14-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-14-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 09:31:01 -0800
X-Gm-Features: AZwV_QgSD9SUVQI9Y0Yihip1NN5Dune2qBBleSwBNI5G1-MsD4RlJ98R8TtLbTY
Message-ID: <CAADnVQJi09vC6Y-jb8mCRfj-OrECvSTMQ_XL2OE8W-B4zPwGSw@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] slab: remove defer_deactivate_slab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> There are no more cpu slabs so we don't need their deferred
> deactivation. The function is now only used from places where we
> allocate a new slab but then can't spin on node list_lock to put it on
> the partial list. Instead of the deferred action we can free it directly
> via __free_slab(), we just need to tell it to use _nolock() freeing of
> the underlying pages and take care of the accounting.
>
> Since free_frozen_pages_nolock() variant does not yet exist for code
> outside of the page allocator, create it as a trivial wrapper for
> __free_frozen_pages(..., FPI_TRYLOCK).
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Alexei Starovoitov <ast@kernel.org>
