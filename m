Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564453;
	b=klROcIYFpdiBDwNw+HSRe+P7A8w36pjhKD838AAXUruyylwEy5Vpdv8tNQ9i+V2gHDL+
	 u/B9HNi+K2rqcLIjj4NuJ59nJmAU1Ci9588GO2aEOz0cUNZi5CuQJYoJco5S4M+dzUBoe
	 c97XV9zzy+IV0Kp03CYpttdJyhUmONDgMj/E3Q01aIK1/4WsViMhFWLa1P+CcsmULNXxz
	 B0xJIWfvKeLu+U3x8gb5VAV/yebnYbdsaJN3gbrYvnxJYaw1Er4M0T4/Lq5yxTnQLEozO
	 hQRfXFsHTsmXO7UmCTX3XwYtvo8pupIfJPJpbehz5xfTjKHD92IJskyZ7lFVRXLzVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564453;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
	b=OUM7MkjM1dzmY0KI6fqYq6xab1Z6JiGHDab8CSx4dNupMx7MqIM3brnBynxNil7zgOmk
	 W/cVtkeJ7fZ2SWWcLzxbj5MZYuTFE+PDcPp0/LGlWiO7jQUzYlzfYvy4PcvNVjs28JE2N
	 /CO8uZ+ooKmkNRBcTCMW1YQ3ayDYgxeDZhLzpgPPFEzeL4qIeIV3pTg0u8ntHBJA8RrUc
	 NxVYnAup7gBrLuYUjMZYb0jUj297fknmZqo50EPEWUSDtOkXBbesoPBsEQoXDK2+srdSk
	 5u7xTbf4VtGVXVWOXyVvpfXbvhaKV4BxyKwNIwLvbyPwzT71hWYHyVs3QgDuhrGflKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cl8v9+P4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C55606A32D
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 10:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C55606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cl8v9+P4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794564451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
	b=Cl8v9+P4SifJh6ew3/5lAKQeOLQXUcmh/PoCgbaCQtIpEifeB+LiAnH7YWtoV0oXMTaaQi
	a6+G51/ssaTUSisPrcifJL+x9/RqA7Hfr7N6iWv2ntF8pte+nMBAjo5uGPNaNNqWjBLkbu
	OvaQGoQ39g+IpGbeFdkT5OiEPOsgSiY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-ANxG3XjUP4WBPDyFSyuXjQ-1; Fri, 13 Nov 2026 05:07:29 -0500
X-MC-Unique: ANxG3XjUP4WBPDyFSyuXjQ-1
X-Mimecast-MFC-AGG-ID: ANxG3XjUP4WBPDyFSyuXjQ_1794564448
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b647bbf8a9so1018416b3a.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 02:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564448; x=1795169248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
        b=jlN3Ppi3VG0qaKFsxVuEj2buq0tRRvVuMQi4Lfmv64Q2hOeP74PMSNJzqHocMLKuv/
         yxLxOCLgCF5UPPirEEbz+LMDciQ7EMz+THrWojzqgSoeh98u8QVdbAs62KKhlrlq+1dH
         aFjFhU8B5PtQx6MZ07pFRHCtE7b6xzczy+je8z0bvh02xAscXLU2xzSZ8EJWGLxKydKF
         ccy2hQDCVTzs2IKqEg5A1Aq0oPLAbqZY+cOsUGWibQxerzCqKy9tRRaAIlx+XWl63+Gf
         7dLEajlGcA1pIg47PbbzsSB1mrYxqEN61oGlNx09JTIQmNidUsMYJlBD0AMmca1s5lF0
         1pBg==
X-Forwarded-Encrypted: i=1; AL+hErFPg/pue1zCnkrUP4ygn3h1DOcqJ6FCWe7lrFtxil8SE9bGJ+5ngjgUMZ3Mj0ejU5V/gkGETNPbRSRC/xMDRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8OlVQ+eM2sabPQ3FjiPsbVewff+Z9JEcQwmEkYJQnzSwXT8SEy
	eWWgLMujwBkSKaQumfrITODJhrasAB31W2Bi5+AHY9tDxmYk3UbIfSoa2MLe7jKKgW4KedTQHW4
	9ucxMurD2JtVNRNhz5orpukMgGUjTX/Go75ufAQcHeZqR1xmGfjWMnYoV4tZO/Es95YiC8hbm8e
	6dhv6gcs5W1U4pyIVPvy7kLBB1B9+lg15vjRSlyJPceoE=
X-Gm-Gg: AYBFou0gzkC2wTXYve1unY1fU4o0qHtvLblYdwYt64u1TusdoQZ3bL1aRAOd7psEk9H
	vterxoJ0cSUUlKrY9HFShmSZxXWfRPWrChY8sJCEZez96iq+XqRl7nz8CwiBDWUVN0gJDHUgMCY
	0DAzP6MG4zKv7SEPScmNn3fnq8V4Q24uEwH4bgJbqSxZO239Vk3GF+348BMQroKEwNH5sDmOdDy
	x+/0I2YGeQErdE=
X-Received: by 2002:a05:6a00:a21e:b0:899:5183:acdb with SMTP id d2e1a72fcca58-8beb3b3e993mr1964427b3a.1.1794564448217;
        Fri, 13 Nov 2026 02:07:28 -0800 (PST)
X-Received: by 2002:a05:6a00:a21e:b0:899:5183:acdb with SMTP id
 d2e1a72fcca58-8beb3b3e993mr1964410b3a.1.1794564447687; Fri, 13 Nov 2026
 02:07:27 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
 <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com> <20261113094423.xgAx5Goo@linutronix.de>
In-Reply-To: <20261113094423.xgAx5Goo@linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 11:07:15 +0100
X-Gm-Features: AclHuK_AIphtSlPLaANmNgJ9inZQe0fAf97a-Oppqika-haxwWPY2pS6Dz2kyJA
Message-ID: <CAP4=nvSEfWgR1GQxVCctBVL_9HrAgkET--UhZ-mdx_uCpk_1_w@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Clark Williams <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -X8Be6vbJIeMgFoXI44s9rlCT7HRjeZhORabfvQga-k_1794564448
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:44=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > > +       /*
> > > +        * Keep the measuring process in memory: the latency it repor=
ts
> > > +        * runs until it is back in user space, and a page fault on t=
he way
> > > +        * (its code, stack or libc pages reclaimed under memory pres=
sure)
> > > +        * would count as latency. cyclictest does the same with -m.
> > > +        */
> > > +       if (mlockall(MCL_CURRENT | MCL_FUTURE))
> > > +               err_msg("Could not lock timerlat u memory: %s\n", str=
error(errno));
> > > +
> >
> > Can we make this opt-in, gated by a -m/--mlockall option, like cyclicte=
st?
> >
> > We can add it as a boolean field into struct timerlat_params and pass
> > down to struct timerlat_u_params. See e.g. 2ff4464e3283
> > ("rtla/osnoise: Add IPI tracking cmdline option") for reference.
>
> Why make this an option? I would prefer a RT task doing the right thing
> right away. cyclictest has a history of several options to do the right
> thing. Is the reason why lock should be disabled?
>
> Sebastian
>

I agree, you are right. I was thinking about rtla setting
/dev/cpu_dma_latency to 0 as an option rather than by default (unlike
cyclictest, in that case). If rtla's idea is to measure the system in
its current configuration, it makes sense not to tune it by default.
But the rtla user thread not having mlockall is a misconfiguration of
the rtla thread (i,e. the measurement tool), not of the system.

Plus, cyclictest can run as a non-root user that might not have
permissions to mlockall. That is not an issue with rtla, which always
runs as root.

So I take that back. mlockall by default is fine.

Tomas

