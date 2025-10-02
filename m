Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6243002CD
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393689; cv=none; b=XAR24v1rB3uWN38vi+iCgb+u3tfUtr8UlwpbHVCHHtCmlNe51Ool/HOVcnaMFXDIE30XQ38Jg+xtPuOtCarchsJu937Z0NrL78xXgJ5H5y/ZULxCrmnXXUHjvogvPikEkGcuL0CrpjcerM62bNFcF0aBDrgryjcIK2RXkq0iDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393689; c=relaxed/simple;
	bh=jBbJl1AjRG2VxRd4ZYUTAwB4pnyvbgugskoI/z/uBOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnxRblaEquCe50Be4fR9AEIAucNSe6rXWJ46ndssSwKkH3OksxywXn513C3t0hJPwYsphh06e7Q7BUCEKaRyyeSdhCuzlWQdcWWLKyC/jzwyLYOeqU80RxEC4gpIoJOJCDtWgG1O1jhLT4B42Jv3dndAQil97Ke2+LE3xBpecpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBgwrvab; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBgwrvab"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso409319f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759393686; x=1759998486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVDhg4/L7xBIfNP97EJSnQJG3YmsVSKM5wAeKg19HcE=;
        b=cBgwrvabQN4k/7XbZfbUQ6MCu8vn9uY4SSdjZ41HCNJxql967N/nOWpWfmBQGqA5hG
         oJo/RSnA7Hx7YRg+Ff2je6znmOu5ALWv36kN7Axt2o6rIw+xGkxfReA82IYVLbcUbR9J
         cokfCz7cbyU8GDf02r+aulKLcy6SnBnTN4yPvChuyQiCfbvKsTz3pKVSkyGRZejWTd+K
         y9/9SdCB05r0EnuXd01FNClNqD+lOftTqG66CS0K5XeOMuAmAmHQXtpEZWfMn/KNzd0V
         e5aPRvfwgQoUsdELT5ZW/U5C+uEQ7ZE99hCzgq+vdNs4yXXWNCJvbjTg37UEnAPw+WU5
         h6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393686; x=1759998486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVDhg4/L7xBIfNP97EJSnQJG3YmsVSKM5wAeKg19HcE=;
        b=Zm6ZMg4zRwGn4b0Xqh9R2DBTia5VWzN0DbDmWkQwL5bfBERsH7EaxneDCVjYCIHeMp
         55z0arLMIej/dFO70VFb2Ghy8BVAzwrQVHvDaX5PtGzabuAOiTSxYOoHpjvMjkelPFeC
         gpcxFN9Usj60DkDrQsvTYSycB6MuRzv9Z4RDNDAgF2CxD1pJbrNbDDlYJ3uE1hAuiBjH
         cqJeBy6W7SLZsaLGrt+jBOZsLeJlKeN0Ywl3xdGFPqP+hXs9KaQGMzEyoJDEpUAk27fT
         +PV1VJjb6b/VAS48S0kThKMJh4yLeDqcY7d1oMV1xOx2piTvSMZzv5gmg4H2KXk/kCkE
         CTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG06PCvvhpxtDKbUqYAs09MMp1nX2hH7osLL6p58MdVYckqgtJcT62llc/Cw7sS4GfwqkS4NDEPEYa2rJrcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpE5B+kbIhiv0cJDjAa1gw4EzOlsh775fazuCCYTOWW/mWZWr6
	ybBdHaGmiwJmNgMZevRqXJFOjtepvG5jRMwC3WE6+UhLEflTOsYXXNe7rcPtesOCU5E=
X-Gm-Gg: ASbGncufaQez0z4B5tu5uLgc7dXT2Kzf6PNOfyeMRk9HoCwDeySQZ8MsjYDKuxjiKTQ
	Bf73qj4vd61n/rS+UbBJvVrsUxp+6lVI3DGWkV/UfI2mbc5IFO3qP3XPFFaFONsnUNOdzP1Shzh
	ZMToOu7rRGvrGgsJvy2HKPMjFe1rXzGm6f/JIeiu6z8oyUPC7eRJ5JgpLYrLBpBh7ZuIGKX2WgJ
	JSTXrD7wRGIR0OMke9Dd5qwMLFtZ/GzlgIwlBo+HqDIsll5QzgH/SATnybaTX9ce2auqkzecn8n
	RPrvVuvO/EIxNXEN5ZdcabhIJ3KQD/bk2MiwgfIyL4ieNTxIT7BjdaI2O7pwXbyV2XWtmpLrmu2
	aE+7DB9wiECA8wFdsrflLLF+zhjEn8GrrH7lp0qF5kXWjvG54C708r/Vwdz/zl2PgNb4=
X-Google-Smtp-Source: AGHT+IF1S+CcnvbeXf66MSf7FcnB6dlBrYPMQf41lK3ANrq9TshhzWTtTWA6dJqkme/KOgZ70cPDQg==
X-Received: by 2002:a5d:5d12:0:b0:3ee:126a:7aab with SMTP id ffacd0b85a97d-425578219femr4466590f8f.57.1759393685922;
        Thu, 02 Oct 2025 01:28:05 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm2591846f8f.19.2025.10.02.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:28:05 -0700 (PDT)
Date: Thu, 2 Oct 2025 10:28:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
References: <20251002052215.1433055-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="burn2oh7hadlsqsf"
Content-Disposition: inline
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com>


--burn2oh7hadlsqsf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
MIME-Version: 1.0

Hello.

Thanks for looking into this Kuniyuki.

On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> The writer side is under spin_lock_irq(), but the section is still
> preemptible with CONFIG_PREEMPT_RT=y.

I see similar construction in other places, e.g.
	mems_allowed_seq in set_mems_allowed
	period_seqcount in ioc_start_period
	pidmap_lock_seq in alloc_pid/pidfs_add_pid
(where their outer lock becomes preemptible on PREEMPT_RT.)

> Let's wrap the section with preempt_{disable,enable}_nested().

Is it better to wrap them all (for CONFIG_PREEMPT_RT=y) or should they
become seqlock_t on CONFIG_PREEMPT_RT=y?

Thanks,
Michal

--burn2oh7hadlsqsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaN43iBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgJ4gEAsLu6RZfLPNZtrX9B33q1
+BNsRWF4AircIO6oJPBwB2IA/1NWvLTbgf7AeTK3VtiRcHlrBQjw9pKutmCZQKEj
zJoH
=8SvZ
-----END PGP SIGNATURE-----

--burn2oh7hadlsqsf--
