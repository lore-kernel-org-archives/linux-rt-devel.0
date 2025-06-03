Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45612CD88
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Jun 2025 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929495; cv=none; b=bCSWEC2LyrU0EJ3i7b9TfWvpkTlKBW6qbRKSTdNsipZiRj8uwuYVuccUVvUbarfmKhYQUftHc2kwtE4+FOChjQK5GbGkyxQ3oCsW/KZFGvQp9QQsaPFlSN6yWW5Phqoa50tReHS7xz/GBlPOhg+i3l7JCqjmHXKHVavxldDXXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929495; c=relaxed/simple;
	bh=a7/f1McLP8f8j2YrW3+25hnvap+duT+V0IMIaqQWdP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsjZw97txMUwGpjPZtHpp+YawV/GJKvNhf66x5vPrelhWJjPqDGW3eehY/RCxA0LiUPzWM1T7i0emHnec+dpYgX+wumyC5CkW3Z1V82LtzRLQ+rjQa5XOqD5Xs/rQQm6bSepiLknCoT84Wfo+VBDj1LKOQV9C7Ovynds6bf8PmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKFbMyDW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKFbMyDW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2349282084bso63402465ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Jun 2025 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748929493; x=1749534293; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XyvBkC/IhUH9m+r94jckGiq5jh3q0FjuoPT7pv/isjM=;
        b=nKFbMyDWhKzWFL09aUknsbvYsp/olIuMbfWyyv1hx0Qaposa+cwtUet8/8+JEKFvM7
         94At1GMryrWxOwr1Wq6vTCukTCPMz8l+tUTb+AB7oGyDxktoQqzFghxh42Yz6lDLs70q
         RASK2/zjwv5AB6bGqF3lfCbCg8ykZX6APsNB3o8ytxEuj8t7qsefLd/ddSbMPRiVRib7
         a1chva8hsTjKdrrsRwC2vG9QTiJG/1SddYA9vBYu6FJNNG5J0CGoJo4nVc3rF4oHWDKI
         tJ675gspu6EkJuqGyhYUSBV2kq/4eY1BNlpqbWLjUvvd3KoGBahStOcJtHpZCr690+jD
         lalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929493; x=1749534293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyvBkC/IhUH9m+r94jckGiq5jh3q0FjuoPT7pv/isjM=;
        b=vOi3vHbObz7vVv5oiJett2WhWF6dkinOJpls5Yc0NAGk96WDLm9pOctpqJQkfRmFT2
         1TDIaW1iMrsKzT/2JraNA1rgmWjdK3qo4UCy1yGaE5pcxcjGYgmg4dcwKbweLP1Jhplc
         dJfPojjgj0KIPb2LsH83aw3cckPuC37706mLWVye2FrenqRIanO5S4ek2r2bSjt3RIB4
         svc7hfmcxByvm6yqC5XqqGujhdNYby8pF1eX1VKqMmWzhdJcR4GZkvaUwvUEsAPcNCP2
         HpapuzLWaMHpYeEGHd2W/Lqx/ZNLuoHfKIAQQ3rItJ9WdUc36IULh71LkO+OuSyyLBtE
         LdmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoU5kNEViAUGCdLz0PJe5DwTTnhtGsOpKCgQjhXzid95Dl+Dq+5lvbkhF426T+Uu3VMCDQHhNrxcHAE/ER7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy04iHC7/73oQBHVosZQ7XA0C539dnDZazrfWFj7l7nriB1bg3R
	CDXCRh7sDsf62YIqN//UAnnIRV59kStypw+3zcotu6cNJBql/Jd7HLCt
X-Gm-Gg: ASbGnctkO+8lYU9/puxaYbLgupxfP+NnPeBLrSCiJcc5fUXT2Uft402pkCIrT2cGIHi
	Y4vCU+XEn6c571/iX+X6vnI18cIDSgnXZQz0jA3yHqNHEwKu+bmlrglZYY1lagl31twWTyTz6ik
	yO+mmUFl9XpEteLGL2IlkRvr5ssP0HOEgURxEIPSIuO+mVEl0jDyJcfW3etJawUI1u65/UYfc2n
	qF+bdn4VA5EHCNnMGHDQYdfOxObTPOkVj51VzQAkQIffwDgL5Ml/HCw4gYQH5bRFZmaHY7SngO2
	Xo4f/dUcWJt7xuioQ+As+RqzSikB3BnE9K7z3cvabRVNE5TXysI2CO9lwNugBc+0f5sJPA3s+z7
	5iH1FWpDUbMTh8eolCh9IZWaV
X-Google-Smtp-Source: AGHT+IHdlhPxl6smtpJ5BjVRIR+OAbl011uevjRpq/WGjMDHyVxpBlajJMsN2VbuDWX4vFaN4xVwhw==
X-Received: by 2002:a17:903:230c:b0:234:8eeb:d824 with SMTP id d9443c01a7336-23529a116damr251972365ad.48.1748929493327;
        Mon, 02 Jun 2025 22:44:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d209f5sm79776055ad.252.2025.06.02.22.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 22:44:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <211aef56-15b2-40e1-8704-58e0fb836cf1@roeck-us.net>
Date: Mon, 2 Jun 2025 22:44:51 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/9] crypto: lib/sha256 - Add helpers for block-based
 shash (RT build failure)
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
References: <cover.1746162259.git.herbert@gondor.apana.org.au>
 <c9e5c4beaad9c5876dc0f4ab15e16f020b992d9d.1746162259.git.herbert@gondor.apana.org.au>
 <85984439-5659-4515-a2bb-09cdad69a3e3@roeck-us.net>
 <aD6BNjkGBKljbfmH@gondor.apana.org.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aD6BNjkGBKljbfmH@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 21:59, Herbert Xu wrote:
> On Mon, Jun 02, 2025 at 09:56:27PM -0700, Guenter Roeck wrote:
>>
>> This patch triggers the following build error. It is seen when
>> trying to build loongson3_defconfig + CONFIG_PREEMPT_RT.
> 
> This should be fixed by
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=b9802b54d41bbe98f673e08bc148b0c563fdc02e
> 

Yes, it does. Thanks!

Guenter

