Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40133CE9A
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018082; cv=pass; b=uz5n2RfHjgfVK9FtTl3RpQw4f0nWzu2cxY43KzpQSAuweMUB8nFZpNpP6BMrPFs2WKGYLnt3nxW9pgfZwTB/bO7O/7oRUJarHl22y5KWVHBwZD1mL5kuzgsW1VKhL0T5WTHHYW05IYKX36UtZv1IfLFAXT5arnUubnDguCqhsRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018082; c=relaxed/simple;
	bh=SSmU4KFIykBxo6FySs6q0GKem+cafJaj8Xh8Wg5ydJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9+Zz8owYlUw2f4B90FYPWdYTjaR4a+hE+UlHzKdeBvcyOSuPU63R6/Jk7KruN7niB9euryZAZyYII3BLXH51uUo8GVCq+b8t6q5OTPer45SOThJBdEa5/WrAxyQvymiHn8O9z3eAvYX1vmy6m5ZOr92JKjp2Dhze8WtSn/9wrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYgYUfw9; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYgYUfw9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014acad6f2so7451cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 09:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018077; cv=none;
        d=google.com; s=arc-20240605;
        b=epqmqlWeM28VLbs5nmSPxgDlvMrd5jB91WU6ytwW4Shj4xCxvjTArT/HpOdJJv5Ju9
         cgwhB5W6Fa8aX+ThgMNoiHGS/pcwuX6bJvdOknGIKFb2Dy3YL5rEqafMKGAHFdi70UUc
         bCcLE7d+X5QvnmfmvZXw0lLhh6RRvOMMsHzG1+/OZvXQXgcXmkxT/GeF8ZguE6jUcOQ5
         5WosHUtfBKZ3hnRG0SeayZsXIrXVHuNNAzdjp5YagPduifBZx6z/immRo9ROG/EaY2bv
         EYM+u8qZM7M85CJKxmERFa02EhQbyxtsLw26ekRq14VSrNdpI1tZ9CHWYpYPzpv0JGLr
         7wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        fh=h/ipCH09C1boRma8zDILHq/t9UeedrR+CULyCN0ZoA4=;
        b=cgWLfKvU4SutGJuq4UaNq65S8Rw7wGBSoZeU9vpwr/CAO51ytd2H6I36O0yNrhT0KG
         gAaT8cm15wvhyxTd4D8fpm7Jgr/9+n6aH6AxrhyL09zeit9tyM9U92RbiSGHKhx9RCG2
         ewIEcO/3ptlw2DOhW5ca0ZFfsNwWSxsYmFwXwg2iu5il4k4Jo3CJs2/vZ83BHQyeNldh
         E9G/tzAWWNtNJ/Pnr/WabIM1nHivF6+0lYWDPrRn1DGpBo+y05hIZk2wJjE45eZ0wee0
         OHjnJbnUBhDSD7KnXczxzhcmmvx6FVOWbDjn88fhfx9GFDFsnkf/gbchXHKDndU3oWXO
         yqpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769018077; x=1769622877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        b=RYgYUfw9QhU5HCKKN7iA9t0MOmraVqFELJydo82c8aGFjO0IqOrtPMfLBpPBDjJ80K
         hpWbVMI6ZjIgGp9edPNBdo7Zo0FVItnAglvrZVegsbabWhgd/Jlg6UFY/YrfGk0TMCfV
         3Jqb8eWvevWTarFvl+QqWvf4zef6OSh/sLSHvgEWwYQadb9Z1+qFJif3HOPxi7cMBt57
         G8QXVjaih3nniWXK86XEaWSrZ88i3TMtbghyY2A5Cxs6+ozJ5spM5In1iBiSmdLZTGHY
         rnV1l6wcPEH3wRTRw6PSAXYrAuPBcxrSyyRqpwnWU8N4ECyNn0WQp0Q7eral4GCrkGy3
         gU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018077; x=1769622877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xH16wCmi7yX9t7ufNOPGVV4N0WTciDc4F9eI40Y8JvU=;
        b=WE7cf7xVDxu73r50TOF0epZgArAqY5IQOI10Eh+2cw/MNr5z3dgtcizN72ZbYAgFoE
         jq/Zoq2JBMzbByh65H3oAPRIgyKIPklhnQ9umHyNBeX6GBAG3wcG8cLNQx4PjMLPate5
         H9r2Gor1BcxHkwpTMVdRRgweinqEupOwhLnnDsqPHQ19c9UwNZRVAxE3OIG6oJ6BqYpG
         1j7Skpty6VERhuYKz/7fU0VE9ufdr7QsNDNgrwzuTvpO11sCgx/cbfBfl4lMShbQIHBG
         CLZU5o8RjMy/Fs6TzoVhqux0RL5gEpAuN0L2E1xVuha57XRe+7MN4bS6Y1xQAyZ44OAf
         EYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGbOzwgn9ccCkSp0aoCKA41Mvc4TsLqnyIx7W3uZjSEHk1gqJtxmO4c6ls1kyNA4bZ46fck1TpU3ev/E6SJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhFZgdah34E/eMG/juhGtezWbJyaaN5FhHmEepsnb2mHPTwjS0
	0IXGUpDsM4d/cbbUdy0x+VjZ4udcT6eA5Sap98ddUj8QVpWM0jxaVhNvW2hD4hSzJoyWS0Wpz5c
	NwYBp4E+0dXbkIWqFuTl9+Y4/z4uTNTO5G+/eozrO
X-Gm-Gg: AZuq6aIvKCYonFMs6EjKz80CKj0lbjqTD90Mm3KX/aRqRt06MgGyeVdN78/8R7KGyPQ
	RNfVUaxISyCvh1dJ8PAhHnqrtspKBj4DaG27WmC6Liiy4glzVMAjiwQNJ9g/qFranxhPjnj7e/b
	acyC8Optu6jx9GzMT9GKKMPcVFNMd83NeXaJ9MW5aof5026C0TqH4t655ZHUileDeFqI2L7MbtF
	NB7xFkyzzi9KaGRSRI3/a1xSLoS4N4ZXp6v75ZDJpM6re6H8IcZEY40l8eO0bCiJMm3Ef4TjtCQ
	jP/LHd1e5a+6i9FPRnUc7m4uIFMHed+b6g==
X-Received: by 2002:a05:622a:1392:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-502e1a8066bmr12579381cf.5.1769018076530; Wed, 21 Jan 2026
 09:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-15-5595cb000772@suse.cz> <dxrm4m545d4pzxmxjve34qwxwlw4kbmuz3xwdhvjheyeosa6y7@2zezo6xejama>
 <6a814aef-7b81-4b9d-a0a5-39f7dd7daf3d@suse.cz>
In-Reply-To: <6a814aef-7b81-4b9d-a0a5-39f7dd7daf3d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:54:24 +0000
X-Gm-Features: AZwV_QgoKQ8T9fdP0Ka4mFnfPpLd-1PHmliqOQBpu_g2EWtZ_-XqW6Axzna0iU8
Message-ID: <CAJuCfpHRrFS3a8=x4shoNXHLtmvkFgV8xASsQL0-hiUBb-O1Kw@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] slab: remove struct kmem_cache_cpu
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:29=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 13:40, Hao Li wrote:
> > On Fri, Jan 16, 2026 at 03:40:35PM +0100, Vlastimil Babka wrote:
> >> @@ -3853,7 +3632,7 @@ static bool has_pcs_used(int cpu, struct kmem_ca=
che *s)
> >>  }
> >>
> >>  /*
> >> - * Flush cpu slab.
> >> + * Flush percpu sheaves
> >>   *
> >>   * Called from CPU work handler with migration disabled.
> >>   */
> >> @@ -3868,8 +3647,6 @@ static void flush_cpu_slab(struct work_struct *w=
)
> >
> > Nit: Would it make sense to rename flush_cpu_slab to flush_cpu_sheaf fo=
r better
> > clarity?
>
> OK
>
> > Other than that, looks good to me. Thanks.
> >
> > Reviewed-by: Hao Li <hao.li@linux.dev>

I noticed one hit on deactivate_slab in the comments after applying
the entire patchset. Other than that LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>
