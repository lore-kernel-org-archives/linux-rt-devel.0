Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203151D130E
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317912; cv=pass; b=MPkP7qkt7wvYRW0mQwvMM04JAkVtNeLs2240gcRDb2LcFPLDhUu0IMvxzHqengIPY6N9hlY5OoRHaISuEqvv8ZofPS6yvh4qFh9mtSs2mWtt6L7CUMtAKbYnop6A0EfbvDbBqV17Vg2jLu2Nhj33rlFDVGC5uDK7sPs2dX7s0eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317912; c=relaxed/simple;
	bh=zUzopiKicuC5Fqd4Gkba9vCqksPM8i7r+cVH5ixZYM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kObVrUd++6AqC0ncQjuxgl3wunMzQEfS0BWNS1dyQnnV6w+5SgXOSPTKirVaaIPvUzyRiybIKbQbbKHlZTIZO589S35Mq8F82o3Bo1yCn6EPFLvdHlWNszNbjNF8sgUlKk8En4DM00KtqAszj5dz/zz3Ga/GG8ZuQrUySCcb454=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPAFDP5+; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPAFDP5+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-519ed52bcc6so335861cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782317910; cv=none;
        d=google.com; s=arc-20260327;
        b=UfiXqvYnRXmcfjSO1/k4AsPCCx3t/6v5xx7feClDxHzgA5Wzv/EJZ7HYcEIJ4FBpew
         qlunTWu4PrcGDlcVYbnOYogI02mhDuAjx1KiTT0rtlsH06xyna9qNTARTDN3XPCpa3hQ
         QvDhrO66XAsQxu5YpHJ6gnJw4Mxs814dW795iSU8MicrGj+aBNHML1Q3Z8k/rtkc1LLV
         szaIDkioEDFNLpA6ViKxzS6gwnK/CxV8WhJh2+rT2pUUaKKC9/2qadcypdl/qoLa6JOK
         0xvxYRA+MhOk+cvzXJuBlulOC//3fGrfaKts/tQmQvOPwIjLdaUetJkQtS1W9Ey9TkrF
         +Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUzopiKicuC5Fqd4Gkba9vCqksPM8i7r+cVH5ixZYM8=;
        fh=UFEeZ56vsaEw0CTx5b0TzjVvm9NJ4R7n708oYlP1EPY=;
        b=sgo3rAzzQy3Jnp5ctcJwsUjlaf9tB95GOIuw+2qXldLSE7+3SVIpRRqYOOXbmvjzxT
         yFR8ErweP2oJB84MsCtAUcfEdpOwVKkrMlxImz4gj21wI+lma9Y5BEtVZP9gt4pcXGM9
         8acb+RN6syw2ZavoQH3YzY7QWedNpjEpS0tbaQ04qFDMNQMUF5FDMp0M59u7AG9qTmN/
         8is3doJogtvX6bGvmuf7SRbOENyGCFv5zE10Q8mEdwhN0e9IH6wweu9aukM3mu5B267j
         zWcuoQcTQf5K9TrQGs/cZvEznomcebvH8IgP4iYBt2q5BE0nuA2dfbyBr9wBQGoAuToI
         PktQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782317910; x=1782922710; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUzopiKicuC5Fqd4Gkba9vCqksPM8i7r+cVH5ixZYM8=;
        b=cPAFDP5+X8dgTm6o/iwXEMIc+YRKXN2m+bqzsn2TQztrs29Pcbkc1AVVwAe3KrwAo1
         vs3PR89p6X//EpE8RSrcCq2qfF3l3KP6Oh2dnGX06vLCqRg+N4gIBEUCiDxiIiJZfbsU
         i+7agWS7i4fr5VVNSDpIdVPfpN4BSsbkAZoAtXEIQF6v/aMgTuSodSBIlwWYshpcbSpC
         lKbJoRlV2UrtO6AaJGmwkVg4gzfCmpcpq38EmMYV88QF6oYbbVnZRociwoW2rPiZe+Bv
         ST9k04iVo945uNJYd8q4a76wBNxuLQKRSluIxnUj0hALZtmPUNDbqmS2if0dY9dhIKv1
         nISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317910; x=1782922710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUzopiKicuC5Fqd4Gkba9vCqksPM8i7r+cVH5ixZYM8=;
        b=U0k6HuaSK4NAghYEAo5tGgDBYny4WR1OETXHnJdXy4ythJxU53y2uwIvWghYgZh6uu
         8dgNIpTi1poE9C/wbkURh8YkxHv4JJs4RIbhWKtqcBGhQgMS/BpT9hikDbIHy9zxz+TZ
         PQcH/RPa0cNIdGYrgNTgmqSZ3ThDa8pc3c3BwfO1zRMOUwmkHHk/mXXWGAnbkc5u30+J
         1zARiY2Q4dbnSyX5Cre3U3MUaUCtt7ree58nslnlNK/w+2zn7bt0jwAJLSv5A+LVte5/
         FgN1JxyYqGOAvcqNCsE6yEqeRFliQt+UkUyKeKNs3CFWevM4Iv6o87bne9PlhpDwMiOJ
         BavA==
X-Forwarded-Encrypted: i=1; AFNElJ/kSR9TtNhgEukc+JKoj3QeOIT1nKnhd/d9ooj6t5UfGrlLlQ1Ul/nvoWDK3XCkWybIIw+ZPkaBd+svnQJGhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx+boClhjJy5ahVntuN0oKaHTczP4nz2AOb3esdIVq88Fz7mzH
	wQ1ufIHsVZoGWQusskp+adzeAEuoZb+985X+HCQLbfoYMKY5FOjIodv42LGNgja0THV1vJbuKRW
	WabN0vqrb4i1o27Dw5jFpSNMYDazLdqNC+fyo0QaF
X-Gm-Gg: AfdE7ck/g0wksJi9ULH7tui3qJDHm1whbwwI0G856zejOitD+fyLqXIpATivRletLoW
	hSBeSHJopADO5qpJhvZpSNd1SQn/9k7gZcAPtWYxtZKcoob+V1TuE4hg1Okr+Z2H5IkQ/HhNpp4
	UkG6oRACH8XusWyuDHy71UD0CdD3OxSUtwop0kMaXa+lTxxzEjG7ZGAXdkIh2oMx6e+NcZg1AC/
	tDsyMcIcS958/P2yAzJ0+sQt9EstPj/7rwV3P5oBEmPsrYRjMXn505IIvFz1r3HyVb32Iqs5hiU
	/4MmtxIT/L5OGhM0WFKDkiRxUBA=
X-Received: by 2002:a05:622a:a0b:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-51a61625805mr11966391cf.8.1782317909222; Wed, 24 Jun 2026
 09:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-9-31f31367d420@google.com> <20260622101153.C08741F000E9@smtp.kernel.org>
 <DJFI52XOQEPO.AH00UF550LWN@linux.dev>
In-Reply-To: <DJFI52XOQEPO.AH00UF550LWN@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:18:18 -0700
X-Gm-Features: AVVi8CdR2pEHyIYJlmDEUnh8LBalNmsNXE7tWkeb0ZhZjkyemuK1PyvVX2BgBpM
Message-ID: <CAJuCfpFERZ3ohA8uQt7BBPocWDAn-3P=RVqcA08U9DvWRWwERg@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] net/funeth: Switch to higher-level allocator
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:22=E2=80=AFAM Brendan Jackman
<brendan.jackman@linux.dev> wrote:
>
> On Mon Jun 22, 2026 at 10:11 AM UTC, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The commit message logic regarding __alloc_pages_node and al=
loc_pages_node is inverted.
> > --
> >
> > commit ab883602f87dc726f65726ac01fce73a498907b3
> > Author: Brendan Jackman <jackmanb@google.com>
> >
> > net/funeth: Switch to higher-level allocator
> >
> > This commit replaces __alloc_pages_node() with alloc_pages_node() in th=
e
> > funeth driver.
> >
> >> The difference between __alloc_pages_node() and alloc_pages_node() is
> >> that the former allows you to pass NUMA_NO_NODE.
> >>
> >> The former is going away and the latter works fine here so switch over=
.
> >
> > [Severity: Medium]
> > Is this description inverted? Looking at include/linux/gfp.h, it is
> > alloc_pages_node() that safely handles passing NUMA_NO_NODE by checking
> > if (nid =3D=3D NUMA_NO_NODE). On the other hand, __alloc_pages_node() c=
ontains a
> > VM_BUG_ON() which strictly prevents passing NUMA_NO_NODE (-1).
> >
> > The code change itself appears correct since the node variable can be -=
1 here,
> > but could the commit message be updated to accurately reflect which fun=
ction
> > handles NUMA_NO_NODE?

After fixing the changelogs and titles as suggested in [1], feel free
to add my Reviewed-by to all the patches replacing
__alloc_pages_node() with alloc_pages_node()

[1] https://lore.kernel.org/all/20260622-alloc-trylock-v2-6-31f31367d420@go=
ogle.com/

>
>
> Repeating myself[0] as this patch has a different CC list from the others=
:
>
> Sashiko is correct, the commit message says "former" but it should say
> "latter".
>
> [0] https://lore.kernel.org/all/DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev/
>
