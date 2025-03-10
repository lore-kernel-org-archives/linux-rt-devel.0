Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB071E0E0A
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Mar 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651139; cv=none; b=ayjgetvawwwWgGL+diCeHRDxOcmcfsozlDgiknMGTB/CITeE/Dl81xHOct5kToFs1/9MGabIvA7oSdfnGRM7zjlDI29peKBO6zQOiGyZbyyn/MVtXQB/m/JV3/9tslUTCXcqxg14taHlMphB4FjLzVTFaH/cnx+Un7BI94Cs7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651139; c=relaxed/simple;
	bh=5lIaOP1OnTp32PUb0Lik4d/Pyum7rp+i44nfbj09K/8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W1c4o7G8DrhYp+DKFHlASD+54jrJj2SnKRdjJjvGYkUl5jdRnIzaQoauDVijUrWMGj1u021AYvjXtCUc4rFZIYZ9XD+kCrHlJiXTWVh0MQfIx59hGGLVsUHw16QdQpteJsLDdwEy6nvNMZXujZ70W1VqcpzOUeZ0jmeGbRN3E2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3cAYA6T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3cAYA6T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso25903725ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 10 Mar 2025 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651137; x=1742255937; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5gzsSm0cjmBrxADGr59p2470Hc64FN9+vxTpEX/n00=;
        b=A3cAYA6TyTsaxVprTkPho5QqZvEwcVA2FdM2Co3HtzYqs1Z6NDXVoq1cFoPyd3uccZ
         jojesGC7MKnLJ+70vI4pWRGpoiCPPHrUm0dl+dUlba7zliduCFFXlVdJPHYAZKlpAqXQ
         izl3MqwnUMnVKiTCOCZFNT/oYYn2h/Mlck3AULd+zU84/HDy/047TECI4phQQ79nqeek
         iJZ4BL6SrZ7bpkBhwGdaWVb3olD+p9W0Rlg/bYI7FsRpBhbwfjZez2OvfWMGbzSR6nIm
         jEU55EDBFa7Ztn9SKL1oBIc+0ywSo8Q7nGBBN3OEBv6mVW60jyyy6gYPzV/SS47tMMP3
         zOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651137; x=1742255937;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5gzsSm0cjmBrxADGr59p2470Hc64FN9+vxTpEX/n00=;
        b=lpXIV95g+fgyVG9I4IkZ4NnNBECt9qqqjFFdVyP1tVh+0adRxfBAtpWPQ1MO5PChwD
         5weN00AlkDT6/yZnSjzeHNfnOVvZ3cijvJSn57uv/eUl9yCzyNz0W6+7LqpmfJbEkEYk
         8lu7BY4+641ylxDT2vbTgoYna1Y+UETZzlzl/qu4XzXbErcDgBGUWtFjrtRjacHwUOyt
         zjA4KsZXEnYBxY6OWBAhI0Ub3cirrsH6HeGsIDrJ2WtR08tjQcr3dw9NrVd8HcdyphW5
         rHHZ82077awTQEm7c3+1mPr91FpfetteHYHmBmSoEEF0EOuULq7hhrvkqUkNgXuk92eZ
         9JbA==
X-Gm-Message-State: AOJu0YwsJpyUeDUoupN5BrShkWxzKO4povemJsa531TQPh9RsXxxVpSx
	r0Qnzt/6ReuWVUwI8QjDkWEqU4jEbVt/Bn5kKZF8pWqhUzEPt7cm
X-Gm-Gg: ASbGncs3UUxTjNAX5YOeFlMu0+/KpoL5vwNGT8KS+IYNHxZsoTDnEVenCqGsPJyhP/F
	xB4o0ilWTjD9Q2ncAri3m0YuuxNubtRZuhk6ytFgGrvg39O/dVahB+qzDZMeNj/LBw10/PTTeDL
	R5iTrxCJYtosgHMSSKrcJ7x5vyaNSvwZ4Zp+5jCb2qJFTL2jkGee+iib3uFCHWJqVucSmhFkEjQ
	adn5VAb+I4zvDWiEKy3dnk9q+K09NMtLwA/xDaAXqvCBRuhpLKx2I/lWlb5whVvk5BL21JAlFzQ
	TPl6CDPh4cQYebqV5MR2N9rgxk22TqCJh3Xo1u7rMf+CmMfzVF4anUVzhBd0wk8UkLEVrUf2Rad
	4CcxfUEF1dvFlh8He6A==
X-Google-Smtp-Source: AGHT+IHLmru6xkgdvtX5umXeqKipdQzfohUmOlxaNrjAAJAhv6qZ71xKuRDpeJfQyDHTU3LnA5eGSg==
X-Received: by 2002:a17:902:da8c:b0:223:8256:533d with SMTP id d9443c01a7336-22428bf7ad4mr247476335ad.46.1741651136665;
        Mon, 10 Mar 2025 16:58:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa457csm84587115ad.212.2025.03.10.16.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:58:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9aba98c5-f60b-4510-bbd8-a618462db941@roeck-us.net>
Date: Mon, 10 Mar 2025 16:58:55 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
From: Guenter Roeck <linux@roeck-us.net>
Subject: Odd random unit test failure with PREEMPT_RT=y
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I sometimes see the following unit test failure if PREEMPT_RT is enabled.

     KTAP version 1
     # Subtest: iov_iter
     # module: kunit_iov_iter
     1..12
     # iov_kunit_copy_to_kvec: pass:1 fail:0 skip:0 total:1
     ok 1 iov_kunit_copy_to_kvec
     # iov_kunit_copy_from_kvec: pass:1 fail:0 skip:0 total:1
     ok 2 iov_kunit_copy_from_kvec
     # iov_kunit_copy_to_bvec: ASSERTION FAILED at lib/kunit_iov_iter.c:63
     Expected got == npages, but
         got == 1 (0x1)
         npages == 256 (0x100)

I have seen this with x86_64 and arm64, so it does not seem to be architecture
specific. It only happens rarely, as in one of several hundred boots.
I only see the problem if PREEMPT_RT is enabled.

Example complete log:
https://kerneltests.org/builders/qemu-x86_64-rt-master/builds/17/steps/qemubuildcommand/logs/stdio

Guenter
