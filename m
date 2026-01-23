Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568423182D
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192272; cv=pass; b=o0pVOGCqd/EPjCKfg9xvpnzzLxoSt7RAjAD41v0ec+E8P5ij2TJIj/vXmg0Zvn708bSPyv+ZsqnBvwznQ91MMd0JA/sdVg65/GQYlSVvzKhQ7+H6o0AyOsobwCOs0a0Cdj44kUpy25UQPT6QGfRSf7bfpkYqNvkDfZv9Zy2XkvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192272; c=relaxed/simple;
	bh=PcrhRkja2BNidi8ueSHFR+dtDd1JMWrricURFvQqo7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV1lYC2L0HJtIg9IVW/Bo5Cap17YTYITAC8r84hayfMlg7XiMKhgMDXCbaXdYMIkrxTTBhQAv6gNiBsJ62jwLP1lt7oneX7oP6U5+rzlX5peU8i1tebRc8UCpmAvNdrJaA2QCTgdZEMJBhA1kp9pcUN1PdQp5OJYOlTKW65ei2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8+f8/PQ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8+f8/PQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2c96215so2187563f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 10:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192270; cv=none;
        d=google.com; s=arc-20240605;
        b=a3paIlHD0ptipzVPotR+Yo6LN50EwWHZs1fMJBOzsV/U2AXjCx9xk7XEgKl2ahsmjv
         D3u4VsGyztsdCjDaGRtXzxhHNiorxlwg2Vh650nc2oXk6JgoDVxOFImEIM5J4rGr0OOU
         RYUvIJ0o/5Rez5zDqT8Aw3sfXgPnIim+RdcBFmDff4m9SxgF4eVHzxV80a4CnR6559tN
         5Grvj8YNTLIkwE3SC8hZ9hbmstYgKsp+ooeaihMBDk2UpOqmaU7zvQVcKRyqEmCu1tL1
         2sBH634VtX7Gs3Rl9gqN2xiTnueQo9jCI3jmAU0CAFiju+yyIojnziRYpwrB6p4titT6
         hgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        fh=D9qE7MxGNcpdU6pTbvSpeYmlvVL0oHFMKaNVOGrw/LI=;
        b=LsgQt3oXkiwJNFl5eFs+zhofYHDkSlLCY8J+4xgc0OwJuyDh9LYBHf3rcp5agihXP5
         m/sl3U4RFTh/ygfdcXlXczxxBI8AOk+hx4QWARcfExDuK2LzdsVDWtMkBUer+EWCnQcP
         0kB4cmus1M8/JIbAtSqopmaR21G3sSHZfgybBnqWVQW4sP6d+uga7wsM30ef8d8A9FsM
         zXvg+ep85z6EspPThB0o3YvCTq/81kLItPx7Nqgq5PHVrH/GdeECTKyA53l1RARxRmWZ
         eSm7CGI1sRuE4OGnQQf5L+CZgBDXXzkXq8eFopJQQ6ZpNvDjaIEmK02bkOyAA7DSn/vt
         Kjhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192270; x=1769797070; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        b=N8+f8/PQ/R42jhMInCUHv/g7tcfz11Pq5lEl+wLiIaVQ3yZnPz2Z9tKIosZ7yxmLfQ
         IwS1wnwK8IVbryKlj787alsk+dIJmpStENjM3WDrwxKRj7bz8lIj0KlTeuSyTTpIx0XQ
         0LpU6F3QRZ2spJ2gVSqXTWrYKLTXxQKfjtGBgcXMJlVcnxLBJY1e0zZ4XfjUYanVUaUK
         RD0a9xFcQcnaUsltNU4NgGwjjSiN2cgiFuLKKbGXyyKRWOd7SFpRaeQ4iFIp/rvEu8xI
         VY7Rwct8CN/S8t4A0ZZY9NQ7eiQmFHMTMi0dteFhkOHIOoJ3SGk/ivZh3Be+25of9Hn0
         j1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192270; x=1769797070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        b=LpbH3rsrihL2/8oaYm/Cv2KwA0HeA8h6/JWjfy9CI+cUr1JhJnAbQWqwjz5tGG4d2w
         qPzOlXojSHoZZUVeaxTrNuYUxKTnNwi9J+0Hs+JCFbPrTS/xs/FivzNtsYxae9YM78DF
         m9FFPN+L7DFI0LAYXq6j0lQ8hW8uZRa6dLjxMRdkZeun9wxXsFp0Hd3uhxznk5ueHhCA
         rpN6mPFvEkQrpcMeiKvss7hRnkaYp4dY18BBiu6RMT5Wvm3DJYG7vjCFmunb+PHWT0zp
         RAmRae7SO9yu4nSHF5MMuRNJMZCrfQIX6InR5pb+iH2TWroWBej29JPED8/CMCw/jtth
         3Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCWCEKUffWI5zgUBm1TLVkTGUXdJJYoi9o8t53+PIkh9X3AorvD9yK19xFOK7b396OqcGhKlXxmIoE1dDMKGeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEChnbzDuA2zMyw/BcwRtHwuZyWgxWghr37PZzHco3nMQCRGrd
	QgU/ms9O0+oqiD4pWNHkt/BxxNpBCzDMfbhgagU4shyJm3SdL3c4AOBJIva9T2IB9aUhDi7G7ux
	fjFLF0BtMbhynhWSWBNiYehpj/Q3dHBI=
X-Gm-Gg: AZuq6aIEiUprKpVLlXdjwyEBhidoCCHZoMpgJyd6He6ZR9QXWmstNKLd8ainTcMSnZ7
	59DD9PiMMSDk6+WbGcJwp3XuI+Qnf++V4GKoKrzc9zn3hBxdnH/ck69vejAqZEUkpAfYJj4F7xt
	xZrNAwwrIlmmgeDfeO1BUw1bQyNzK3abg6ch78DuGIjZECIYk+NyPJAtVCNHqTKBm6xpNX7eLiC
	JZpMrtYxLI0DE/Of0IU6HoAZk8CLubTCQR1Ivp+aHKgArjNphWPvUAQoxCctmgmral+TkkZDBqA
	W4WIZ5DYHgIoxRhR27MKAluZYsFc78D/0sx2+mRnZ91j1WLp3noQuEdbcuIzgiCky8j4G40P
X-Received: by 2002:a05:6000:2dc8:b0:435:a83e:88e with SMTP id
 ffacd0b85a97d-435b1587c9bmr6392632f8f.2.1769192269543; Fri, 23 Jan 2026
 10:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-11-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-11-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:17:37 -0800
X-Gm-Features: AZwV_QhM-NYlnccFIjcj9RRt6cZ2UOQ2HcV0ateutcQQrobA-XAbfYILlKDwm8s
Message-ID: <CAADnVQKbuLD=gaC1W9gtXrj9VdwQCqt2f_rtYwF1Tc1RcUOjKg@mail.gmail.com>
Subject: Re: [PATCH v4 11/22] slab: remove cpu (partial) slabs usage from
 allocation paths
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

On Thu, Jan 22, 2026 at 10:54=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
>
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab(). In the
> latter case we reuse alloc_from_new_slab() (when we don't use
> the debug/tiny alloc_single_from_new_slab() variant).
>
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
>
> To reflect the new purpose of get_partial() functions, rename them to
> get_from_partial(), get_from_partial_node(), and get_from_any_partial().
>
> The rest of the changes is removing functions that no longer have any
> callers.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 628 +++++++++-----------------------------------------------=
------
>  1 file changed, 87 insertions(+), 541 deletions(-)

so much simpler. love the red diff.

Acked-by: Alexei Starovoitov <ast@kernel.org>
