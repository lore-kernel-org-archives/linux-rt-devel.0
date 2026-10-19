Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435640;
	b=Og2F5if9khyaUNegB3/kcXZ2nx2xmQSHIRr+/JfQQDK6vbIt/pOwAw204S76cYGuL7ZN
	 UVfo3PI1oNmKddCWRfmG3dMXg//N+24zz1ClSjQI1deyka7bN7teWXoZ6QHRC+GLlKxRG
	 tOyP7Xb4vux8PoXAoX+J+m8ZRfNKLE+VuHlf3TJVeFBExbMCMIPXE1+8eo1YffjQLn3Js
	 tvAUioRPSoXHvVKWvuM8h4SLTPgKkpPJQogaZ9saBAuYR/riFOwS4Lp3p+9QB+xEX7vtk
	 Z8X2K1WZwwdzkvI1VkaPAXkqOyb01IEBaJfh9qg/58fgkf3hGmW0nUlN3bKbtFGBptA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
	b=vPC4rQNp+PU/9fliZAtNS/5JOdA2YGoWgw/h+2U7efWp0RtfQPB3zbtjLpVTWpdUMrZy
	 5wlcpBy5jbpkIHpBhE9rWoi1/aOtqUytVPsUHy9lREtccg6YV+VKWLsw8z7hXvZXQKBdO
	 GLANq0Jo9HOtw4n8mjWWdWkckEREiBgkk5zqWTr80dr/rbCpMTnHB5RfLqHTEjIqKNUgG
	 YauFoG70VqKa0qLDdw94FXlM8MnABxByp8std4I9N1VAKqAJTHYj1yPIdmW5hNjhcf5ko
	 jlZxdrJA9l4LqnmSXXpm9r4IO5S/MKBHXNu5vH11gnZD1NpSQvnxB5SQ+rFyITGjfeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=adsCRGdA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC6606A325
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFC6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=adsCRGdA
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so6346757eec.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 11:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435638; cv=none;
        d=google.com; s=arc-20260327;
        b=VsqQ5iwKVP9sLFIUrQDvF2dBGokcpHY4dTFmq+2vc/DyxOm0RIn5htfl1xs3gdqemx
         X74oQ8pJ+PAJnSzaUwsutQQR1sfCB8t5ieenbAHAvdPpGoC7mxqqvVa3Ic7057cHxQkX
         Bw8mvGPUt6OO7Fu2hNcCeJ9NtQcJLzl9EH9QX2BtiTu2DkLMO9aUsTSpqxL9Lkj0RtaH
         VwHN7yApI0hMO9rsgzJjpqJR/xd4ypeNkZ9SIv5yI6zDch4s77WPNY0jdFFNnIY6Ivay
         hUiRZE487DBgzXV2G9yINgQCSTu+vZm7EA2UQ2tPnAVUyTW8QAecXzaGRJoGMVxlKscy
         mQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        fh=82cnP6ye2m0Li3qD7DiPGMmnGWkvZOp6dd7vRTR96xs=;
        b=rZM7YSNmdyfyh5Iv2APlF8yioIUZiVYqO64APSdh2IPHPh/adO5trahqtkYp2HzEdc
         Sk68YZZiLz5wcTvOiCOY9nkMwi8YlujXPhlYbRAXde0cY/mvQ39lCJEAIK69kN+boorm
         2drPqt+/Hq7GX21EAk3n++R3WYYR8r8jRSW6uKBI770tAZofcwkbxRzHSvMqkRtZC8eI
         C61v5lzuNopFpVXI2RZpW6KwNecoFbPLJFKg6iLZXYMnMW0444RTljcfTspbRJuko/Oc
         bCJBU99Nf6nyE++tvXGWaBJVO1sNxdMv5svto9PMRYo5PrF5jhsiemd9ZSzP8PMR/iTO
         s3Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792435638; x=1793040438; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        b=adsCRGdASmvUMEp6yzZPVzpNxhtFZHHK3zBbiWqT/t2dgPiYmbZ3takMDaM4EUAfJS
         4lyw5cV6peTbs2tLWfTLJZJ2X4m1FgrDEjs1AsgKLKOSClzeyqUHBShjl05r3nTJ2pLl
         ZX43z9tUMZarXc7po8NU5gK89OMCFXwltbn/PGxL60+bmFRX0jfL0K5H/PcQR2XWj5DX
         VdgBJF50FrPHZDFsexIimNIFhrL7ZgrpcOxyze5AVUgxIHNuI5VYq+3BF1NJMknOdi8Y
         qknjyaa3YUYF6qqryzN600c9Ak+JNnwxWPtDc9mZRHQxcAR1k6EJ1EsXaBprPUlU8JfZ
         UCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435638; x=1793040438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V41ZP6u0L0y50jwnS09ezlAGGz+bWXVLsjSU2rSv7VE=;
        b=sIvci41eXlWlNLgSjYJGgf/fOVsD1PuQvFrbTjCiiqcq/rY2uv3OnPMj9NXK/mLeog
         ELmfQSLttXXfUKNJMbvUIHSicFrJCCPInnD3kOgBhw70HPipyeLUrjrMGXG1MEJdyAMu
         xExmni650OB1n/kvS6IjGXpCpYVZkPKkq3o2IcQbKfGEBa4KbxGO7HnFU8vziU3Vpsft
         oJLVCW1Ip8kSHygoDrzrp8Kzw8qefs31Z04gzVQMMfR0D18x68wEsYqj39XAdPCMnpIB
         zGV1jF0ISjt//r2gvtE1jVutKFUhaQy8I5szhFPDob/TBzeB/kgzi7Mohom5XSLwvBCp
         T7eA==
X-Forwarded-Encrypted: i=1; AKwUvBwyGT7KLyYj5YjrIytNPuw+8ZHAwrUKq3N7E2XBR2BNMshdL6yyksc40Bfm3lnVm98OXtOMKaj2JOKS09+EZg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKmGKZ0GDOe7qW8YuKb/PerxObAa21EkvAN7fJMEWJdbJtGOtCg
	vTUvOivevbZtBV2+jcr7WMpXgaalldF67WRMUH6yX9Hjnv3U+fNG5pwMIqt0vobJaKCk30Vz0by
	I8pCDR0UFRIMgFxLFhyb1ahXnpIMPMzgadAQBbLlNmg==
X-Gm-Gg: AYBFou3tfD0RWKAGMGmPFE71n/d+qP9NroCaVmDAoXztMYTuNSs0yXHB8AFSS7ndTgk
	mwcTSZtnq7ngn9FaYkwL5wwEHe7lB7tDRv7xfaAw+4uz5c9yroFQbSKMh96828S5TsjPaWJwu1p
	YOClt9UaRW0xdmlyA8AHVauy87WdjZBdJ0piVH28Jek1RuFTtCtCP++esZlDcLMC2jjRCkG6M9q
	c3etQK0g0Ved3UDVuXbVfRAdOdHPazCKosjqP/y4G7Ic7+yh2zEQ2z+BgzoSKjCLkKlszy0eLuy
	NnkM6f9RW23fxWuQsQaIhvI6igspfA9ZfBVUj81fZFFhpd2lRFMnN8UalEZbhYLj/A==
X-Received: by 2002:a05:693c:808c:b0:353:7e28:9c58 with SMTP id
 5a478bee46e88-361a3323b50mr13739930eec.41.1792435638102; Mon, 19 Oct 2026
 11:47:18 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019174258.1375583-1-jkain@nuro.ai> <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
In-Reply-To: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Mon, 19 Oct 2026 11:47:06 -0700
X-Gm-Features: AclHuK8UH1QOH2EFc3ZT-WkryAT5MFnjmPJLltAW_ky2Q_LYaLtOPSHKqrEXEko
Message-ID: <CA+Y90PjRyR2czC_Y8G3wdttj2YoDMb+OfPDR1_KGhbu0rDquxQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue rejects
 a free
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>

> Say not to very verbose changelog, that nobody will read.
>
> Since commit 844c9db7f7f5 ("net: use llist for sd->defer_list"),
> skb_attempt_defer_free() increments sdn->defer_count before testing
> it against skb_defer_max, and keeps the increment when it rejects.
> __skb_defer_free_flush() returns early on an empty list without
> clearing the counter.
[...]

Thanks, I'll use this changelog in v7.
