Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A64D9F6E
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546384; cv=none; b=b88WA6wGyCMLyc8O4wD7BtmwJckRuL2rouCFXqzWSITfYABxBWW9edcyNpcPIBKSYm4DVSC3s/8O/OKUBKmHBH525MB3G+n8Hd2TzAbzx/PppfHd4Yc/egij+XWu8H5mYfVjBsT9O7uvQfahRIaQ0FiODCDUMJERGaqy4mBWkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546384; c=relaxed/simple;
	bh=qfn6Chi3zQPoGrRKHUmzBsOFSj22hZyuE74D1Bo2Iiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDEHF688bWcjcwRvKU6MTb1x6nZfT2RyUtxPFefJqveTjYwnjAEBJmn0SDOcleHog61noN0EDmPKLKleoSuM84LXuCzQRwiL/LINwwCv6SzMO03ZtXpqlFZHTbjsjPIefw9b7XjDnjR5a+NkvT8VxibGHoLqiPPW2t04/VsIVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Si9QQfsL; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Si9QQfsL"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2d032846c95so33375525ad.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 04:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546376; x=1792151176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BQ6/HQ3rrLrwxJjtL2d0lIbMN8Q2NnassUE+UKdIN9s=;
        b=MAdyvk8KSrllbNipfX3ORFbpdA0n1lw5QcElha7U7cVd8RY0niatY1MklXQEav31Mp
         lRLGVokAUPqS77PeEFTMmxab6GG1rNJunVsHxqu43+PQ8Xon8Fi91cu8SMYUP1oKyhog
         /s+vnaRYxbVD7BPIJsh3NnxGFvJRAv84Q740qAZnMuxBM3TKDW0nxduSEwQTbnu4Ekjs
         75BIjOKIT5E3N/vwjEy2IGfxBigY8i2/wIb/bemEWJO8ysijjc97+TM7ZwRHnd3u5l2b
         RSWXmrcWv0BJtmy/kAoR+fJLGIc9sNBbmDa7hyMADlCU3GYMWXhHE64qJ4gLCHZFACCQ
         +YdA==
X-Forwarded-Encrypted: i=1; AKwUvBzHsz+ZKzIGb0cs1CT/KGSSG7eYudilTUzeVyIPXtXUDmA7VJY8wX4Y/9Wom5TrrrhP5DMqKoPAOCgc+nV31w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKanPQf3YjqPYEvGYIgivLyqakd9XGBYfXBbX2osVTQttcjXd0V
	cOCogCg1T969+ObR4FyZyk+kVe1acIbBOqELh9VL7x8/S/LnPjY7ya/yhFGcTgTa3EjGGkj3/P9
	u3gzaqG7GXpIXevWFXEhtuCcN6u/vuwNtkt35JjcPY/V0x9VzNtId/voo1CTTK87U4ziuEIk4UO
	hWB/FlcoXsIc/kI59Jn8O2CoQZev3deizUeqfoqMmzK7TWRQ5UqPz24P9G0nidbdjbcehKDRUIZ
	rGgxE/OWyD62xZxaSoQwbLmbPr2
X-Gm-Gg: AYBFou01s1u2Pa8H7br6lGR0/GPriCvPGn6ozsI1XSQaQXC/51nLbE46D9MBesEoa6B
	B6+1U+7DbDcjl2oZuE4wkgxDRHrCsaWQqmvT/OReB98R7W/LbuxNT6A+9PoeId0E2F58HqWjjk9
	IP7OTZkhcp0h1ypydoGLEgyi8i9iFui0utxcdXw2+CAPZdLLnAyXwCDKf+0uq9SJ8PFZLnyLvx6
	Vd4gXZP9FQ+1kWznz6zWuvO3brg2rhfGu5FpliixxWQ0I2xHd3GxY4TS901TBUA36aD8QuOcDt1
	uDKXmBSJ1EAhvuB4q4z/4SLiYI/g62tSkuhlsShXM4nSfZaG8RyE7dLaiyAyV3lUf+67Kus+zFp
	YUz2zeg3pL6GXVTT/uVsQXnA2JO5Py47l/vaq1tbaEBFWvsHha+QsDCC4ETEh4n0LDgqJob8G3H
	Qd0mKikE8c16zYY7CADRSVgXUE+Uh/QHiWuTtJcWyUzA==
X-Received: by 2002:a17:903:1663:b0:2df:83ce:724f with SMTP id d9443c01a7336-2e842abf78cmr14906965ad.30.1791546376287;
        Fri, 09 Oct 2026 04:46:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e84218ed83sm745395ad.36.2026.10.09.04.46.15
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:46:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso12003120eec.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791546374; x=1792151174; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQ6/HQ3rrLrwxJjtL2d0lIbMN8Q2NnassUE+UKdIN9s=;
        b=Si9QQfsL0UE4A28EIDy/cOyBCN68yBIzqt7rYpJhXEa5SI9aCClAl6LTUBRq4gfk/y
         wEnppL4q12XWiAqb+bLNxGZ70WxVhHSJ9THd54KmfQMuWd0PgKeiYNGKaM0B1Eue0J/j
         WAn2WhoRqqDORjeB2WrVrGV2G9kHE8sakfvuE=
X-Forwarded-Encrypted: i=1; AKwUvBxdyCIjvQD2lXUC+S0xLbByE8nudh5Cynj0+Yakjd6ubuPARl6UMTmeqe7DknylK6yEVXqGFkSXdQCZr+IE4Q==@lists.linux.dev
X-Received: by 2002:a05:701b:4583:20b0:151:ece6:b171 with SMTP id a92af1059eb24-16a5dcf6262mr2016597c88.14.1791546374223;
        Fri, 09 Oct 2026 04:46:14 -0700 (PDT)
X-Received: by 2002:a05:701b:4583:20b0:151:ece6:b171 with SMTP id a92af1059eb24-16a5dcf6262mr2016563c88.14.1791546373450;
        Fri, 09 Oct 2026 04:46:13 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm9791902c88.18.2026.10.09.04.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:46:12 -0700 (PDT)
Message-ID: <448913a7-809f-4ecb-89cc-3aa3bde08c5c@broadcom.com>
Date: Fri, 9 Oct 2026 13:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-wireless@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
 <asR1TaKQJlPFqEvR@gmail.com>
 <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
 <asiX75kRueyFqWuO@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <asiX75kRueyFqWuO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 09/10/2026 09:30, Karl Mehltretter wrote:
> On Tue, Oct 06, 2026 at 10:27:27AM +0100, Arend van Spriel wrote:
>>>
>>> Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
>>> without txq_lock.
>>
>> This is an observation unrelated to the patch, right? You mentioned in the
>> patch it only covers fcmode=0, right?
>>
> 
> Yes, the cleanup observation is unrelated to the fcmode=0 fix. I
> mentioned it to explain why I kept brcmu_pktq_penq() for normal calls.
> 
> I'm looking at a separate brcmfmac FWS-path RT/netpoll fix for modes
> 1 and 2. The prototype defers IRQ-disabled transmit to the FWS worker.
> 
> Are modes 1 and 2 used or recommended on SDIO devices? That would
> help me prioritise the follow-up.
To be honest I ported the whole shenanigan to brcmfmac, but I do not 
recall any projects used the functionality in production. It is mainly 
intended for SDIO devices.

Regards,
Arend
