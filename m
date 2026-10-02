Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1522D785
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900250; cv=none; b=ZaqzL9LPynBxiYEWOmVDKNIiLsv/+/pBmK2Dhxn77WMABXUbYzATWPc1lzNRSnhDMqGgr29yZPJteFEMhcAURkcOm4nxRzao0niLm0Oa7N9EGcIj9MQiB/QxSsRnGwvJdNF+yW9uI6LNo3of6zY4eEL1gowmDMmCBSFwzbg7roM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900250; c=relaxed/simple;
	bh=uU8ecgL9bHXX7U2HdHoZ1solGVk0L+qo7jnXMGu7ZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXAaw96FBnxDfTaWPBtZmg57IpCxS7VlG6NugJhcxMLmgwPinoh1mK5Dr4pHQQlgsHp68NUm6+Fiux54kho+QUUmxaybhk1GA6EhkM7gHYtzx2BcLI5G98wS4V3wpkU6O8051M5dPBbDeRNycdBJpbqwy19IPSaFHLMYCWwMYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9bgi02+; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9bgi02+"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso22428045e9.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 01 Oct 2026 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790900247; x=1791505047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=px+/xLsiECPGLRTHgt+4dAM3tfLMzLHXRYmynoZyTdo=;
        b=X9bgi02+zBRPMLwbCodpjB/MhszRqqK74irP1iWpu0fEI/gCC8NZa1ze6zv+ixep17
         aI5VbLrFmizmLJNI9S5d9Sm6uPEBlC/GThEhIuaMQDnfjh6ZNIwhlkvHNNrOzaw3txLq
         kMymuVQypx3ejtf9LHrZjMq3dYkhprBqvhZzmL+y8lpF/90PcIKyWOpecmx3SH95id5F
         2JI8f10sgSFs25BnX3IDSwcwwPfJCCvBxG5xzHgCugGRVFtQ+XVcJoWckxRb8wu3c5uT
         OO5I6Bco8ktQr7ntNgAQa8xV2mFAs43PR6WtHTg75Wdu+ao5SywKzjfQwrtsifln90Qu
         SdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790900247; x=1791505047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=px+/xLsiECPGLRTHgt+4dAM3tfLMzLHXRYmynoZyTdo=;
        b=CjS+3Uan9vX3pz3jme/RAbPbPgjn5lrMSopLaNApC0O52lZXnT4eFPruUoDlTUTsvP
         uyjthvCBfNgDh9v8pW62ylOy91/PzIBwfqLDdEkpfO37ZKgW+VAZeoVXS+kjRB2Ii08m
         V6DXCWNgXqf7vfuFIMWR5N4mWkHu7czvQyFs2SPOF2PBORHnpm59QBgSB8Zfc5v45AdP
         Emikg37o5Uq+7T5RShhg1bjDlFdmvzaGIiQmyRp3EjEMKPvd4IHyEzDt1L7PLXoI/WvF
         j808ymbHiAqj7yNK7d4o0xkoeulAmNsQ06syeOh6FUKn0KP4sSHhXEZIfpf5SJRu/GMj
         08gA==
X-Forwarded-Encrypted: i=1; AKwUvBwGrrUN+wdT+BH39UtMlM8v49e0Ic8Ccu1/qNQQF1eLevKZj6irLODkBjOZ1JozTvJK4Rgy1GsnlvmH+OQM7w==@lists.linux.dev
X-Gm-Message-State: AFuF++n41IR+j7LM11OQDEibqDqIVYjpzQnGzZmpziNd6TrETId3G3Qi
	GMOl5VskePbbOEikYeC2Etc0bY7AFhWxZIKjF6AnJgJERyhAXBqm6tn3
X-Gm-Gg: AYBFou05aIj4A/Ya3Js9cUmdDauiJpuzpFncXaD6kgZ12DePcZF1kd91Ur7D5+yHnAQ
	YjFCHsFYHNJb7PBZMB5gWrXCLavCCL60Kcq/ap84miL/NdIcuLSCjphxRVrxyqEb+eG9IjecN6d
	49/OZ+bYrD5jJP4wcykrnp1dqJLLlK4Ryr9nJayIh/4q3erIQBZfPBnDVwBu4eaTJb5JGOp29Dr
	K3yfErlN0qlelPOpB5rhg/Eo2G4POs43/INV1VvOEA4bFc0zzxxPJ0+zSu7+ID0pZzxzqaATQzU
	efdf31xp4UIEt/iUe6kMEnt5c0ZMkkVPJ/2bG34IcXiOF6TAIV0Ei/j0oMaHqRFoEAAk4PsyqgS
	YCRshkeqGc9RtdinNIBeYjXxs69xZj05FBAR1BDDFVASQpLizQ2Us3jp/ZKmQQbFENRUGoFaTNe
	aghLkrHiY5UeC+k+Ig+cACTpl4s0sbTuE5zoOodoy7iwy72+9U2L9iUTZgQw6PBtox+262Lnskk
	DtOQhRNdc8MHpe9G1zbiLS39S4Xq3RXUdwFoaPuQGIOn5uNcGoE1XtTvYm2aiur/u98j6nEDKjL
	V5wP6Ek+LmqTPCTkQaE/AN15R75+J19u3QYNpmXIa+stBNFFZuy+Kt5UOr6Uns5uoAI51MzmFmD
	9xMhKzF9ibmLSi6yNkDPi
X-Received: by 2002:a05:600c:45d3:b0:49c:fc6e:a3e1 with SMTP id 5b1f17b1804b1-4a0276f556emr18772095e9.32.1790900247466;
        Thu, 01 Oct 2026 17:17:27 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-b3ca-3a01-3deb-81e4-0dc4-fbe8.310.pool.telefonica.de. [2a02:3100:b3ca:3a01:3deb:81e4:dc4:fbe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03048abc9sm7487875e9.0.2026.10.01.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:17:26 -0700 (PDT)
Date: Fri, 2 Oct 2026 02:17:24 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <ar73Oi6r__PY-RE1@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001164355.212c8ce9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001164355.212c8ce9@kernel.org>

On Thu, Oct 01, 2026 at 04:43:55PM +0100, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 21:21:02 +0200 Karl Mehltretter wrote:
> > Fixes: b6cd27ed3388 ("netpoll per device txq")
> > Cc: stable@vger.kernel.org # 6.12+
> > Assisted-by: LLM
> 
> This slop is definitely not a fix.
> It never worked, it's net-next at best, no fixes tags

Good point. I'll drop Fixes and stable and retarget the series to
net-next. 

But first I'll wait for input from Sebastian and others.

Thanks,
Karl
