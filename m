Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616C3B995E
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Oct 2026 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275254; cv=none; b=n+9GqUcGWfyFbTfBlgfOJgTGNGs1JC1odcwbpq8Ir4ASF75Z3QSybnNKtmVtPmqRP1J3nEJdRl1Baj/zxvC0tErwSBu8Ktlwfrwn8ZBlAa80WrpAUMKT3UMLLsHEw3pOC+QxkBHDBUuN45Bl3Gqb2fLjXHPaaDHJtg1sBrjyvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275254; c=relaxed/simple;
	bh=AhTSB+hX8DW5/UqPj/kPlDv4TilOhsZezix19Q9Y0hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBum2dushufF/GsoS8FmTTI4aqToSKMJBqUmmqzcAIVGmC1tj3QsM2NVNdASxkTLVNNWDUN0RtPLxG2H1oQV78P47yucOl+CY0gUCyrQ86wp95HYl2w2A6oBaZ4BXJS0Ni51b2esmZrOW5hpfAPILoSHU/OqVkUnk8Q1OsJSKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LFrVVh5X; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LFrVVh5X"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93e7ad9f78dso35859185a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Oct 2026 01:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275252; x=1791880052;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aO7ZMNOXH20rZFoB1a96CWPC5jLhbhIpE9Whu53E080=;
        b=smw+o4xRcUBk3mYYqcX0eXkvOPmEA8Z5P0I+q00igu4pLswhkGDAU+mRtT5515HDez
         E0tAJ9hdzQCNxtwJxbixl89zieEd04CMEHxa9Wqi0IpRgUXxX67bz3GInW6wIme8yuwe
         hWbu+tj3p46o/o2JFurZH6aZ8aMSvXbrr3kyvY9Kz4Y3TpgGGEftNTRAWdlP9nfe7oOf
         2opt1U+v4L6JhC9QpCTx32ba5P2Ds+a2CLJX6vWkAo319rqppgQu57qZPURbYmpiXNiB
         hwwFbJcvDr/z03xInvlvQlNXozONbZ0IVZB5KiGEl2uWb5Hk28slshuRU5PPXWYZyfMo
         FuNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFhaQfErIdH7UqXnGqjv3iwehS9cyt/xMO2VYSfH2iWEJ+BIzAUGsdSVOyct2lPLaVqt+0N/+ORlpfpErs1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++m7YzP3Sj4GGK2CmpyeLIUKN7AhIFpUGlmlqcku8LN+U1KZTSoi
	yvNQzVEa27XQxhvgDjQutHIj8yz4O4fgvhaRMO6Jsiu4ZdAvRmQEefCNjjghwBMBV2rc7F7pK0L
	p6z2ylGJ26Nf8KoITzvsltXsjmLTyLjha9RauUhYiihpEjJTRM/iN+cseikXcOjjZzsqhQNtGtv
	IpWFKnwrM+fIZAZbvz2AlhIuIOb6+lw/jlnBpuqMjIf/gPQ0v3sHi+VGeOre7pDm/MYe8abkMhI
	IODZJe5dT5aLjxiCDkvRpHKe8wV
X-Gm-Gg: AYBFou3KvVAb2/vgTFI4P4RM6J7r/0sq26h3rb1frKZ42yAklDl2j9VyXq2ru0hJpWx
	juEGVKgSKCCiph54D0b/Wg7mDSISMAhvxYLQCLbOEvPp+6QRI7JWBf7g3EEgtxz3i0eFWM3xKWJ
	eWjPVmKo4zAEgRnozKFsNSJPpwlfUbpDUq2ksOT1olCO34dSYJkmv7JmeTUkiBrzohP3B+fRroa
	SO3azJDOcuHk+Ex/gY/PtSK/e7gAgMBz8Pg6S9yDoraR4os4B8Pt3m+ltkTrFtiO2pC6i1YyrEF
	6ychZe4A5/0uYEgxpiP9TansErC2+FlGiifuWxTrK7JFzD1fJwup1fLN7XlaUt7fw7gVhup6gyK
	A6uHjeKLfeRKoPD8Ivd1Rbqd6S/Kd0+Q59lESUC/lAJvvX4U4tsrlYcw2R8lLvfKEyLWJLDyR2j
	tCFh1mXZ8lBdlrPJhVi2XcdUJZe9kaB9RdOkcgqhDIdA==
X-Received: by 2002:a05:620a:800e:b0:93e:5f53:28de with SMTP id af79cd13be357-93e8f4f80e7mr110898285a.51.1791275252498;
        Tue, 06 Oct 2026 01:27:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93cca1ea26fsm503245785a.3.2026.10.06.01.27.31
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 01:27:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510a481ae9so4840555eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Oct 2026 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791275250; x=1791880050; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aO7ZMNOXH20rZFoB1a96CWPC5jLhbhIpE9Whu53E080=;
        b=LFrVVh5XSxB5oZk+ecGMpJAYThsOVHnT+qPg084xNmPtD13vazbWJviaj6s/kMSQZw
         Wcn/exeLzgA4vXfUSfjI7lZyO0/NI8sRhbt4gerUFeESv4Qj3sSVLGcBDQOm7+NF+RUa
         hNdPlB9BW4zEZzXweYgLdJzQ0kIMzNF/OkNAs=
X-Forwarded-Encrypted: i=1; AKwUvBwfG0zjYyjWv78MEzmjeOlw6uD1IxTyZA9LDi7sJ74ZT1bYAVqKyPqAsVcDphzyWNudJiax4JKtd8tfyb+wCg==@lists.linux.dev
X-Received: by 2002:a05:7022:288:b0:143:4d12:396d with SMTP id a92af1059eb24-15ec7b02b1dmr978948c88.26.1791275250340;
        Tue, 06 Oct 2026 01:27:30 -0700 (PDT)
X-Received: by 2002:a05:7022:288:b0:143:4d12:396d with SMTP id a92af1059eb24-15ec7b02b1dmr978913c88.26.1791275249521;
        Tue, 06 Oct 2026 01:27:29 -0700 (PDT)
Received: from [10.176.3.41] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm5335442c88.10.2026.10.06.01.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 01:27:28 -0700 (PDT)
Message-ID: <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
Date: Tue, 6 Oct 2026 10:27:27 +0200
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
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <asR1TaKQJlPFqEvR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 06/10/2026 06:18, Karl Mehltretter wrote:
> On Sun, Oct 04, 2026 at 05:29:10AM +0100, Arend van Spriel wrote:
>> Is there an opportunity to reuse/refactor brcmf_sdio_prec_enq() rather than
>> adding a separate brcmf_sdio_prec_enq_irqoff() helper? For example, passing
>> a can_evict parameter:
>>
> 
> Thanks for the review!
> 
> Sharing the helper with a can_evict argument is cleaner.
> 
> One queue user does not hold txq_lock: brcmf_fws_bus_txq_cleanup()
> dequeues through brcmu_pktq_pdeq_match().
> 
> Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
> without txq_lock.

This is an observation unrelated to the patch, right? You mentioned in 
the patch it only covers fcmode=0, right?

> I combined the helpers, but kept brcmu_pktq_penq() for normal calls.
Sure.

Regards,
Arend
