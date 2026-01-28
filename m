Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A822D97B9
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597062; cv=none; b=rJMik4UbYnJEUsw3TpVwqDxOwjrcL+AXtjaaLvkGKkrJHevgMU6TwTR6ZF6CfqecT6HYuH0i5TvTeSWJ7DlZ4YFlWiGdys6vb9XV5zj13x0M0V5quLVKE54jVLN3wg8cF30CTrkCTNGIUKpui4f7cuxXCDBHjgr5EQrTiVMwObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597062; c=relaxed/simple;
	bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIG0N7MsCWnqHtTyCXjsejnWQMMfN92Oe7YATDsvh/LcvF9U5kOnuNG4u1RTA3wrBGeuen/MQyl1ezfQgq1mJEOadZuPIZeWRww0BsdjExYnwlj1Ptm0B7b6LnbixrWC5s8UKeLghzhU9LlYEtoIXUVQHiPNBBkeVp9APexWfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwunk5LM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwunk5LM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48049955f7fso57796935e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597059; x=1770201859; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
        b=Zwunk5LMoyxJ7dnsK49LqMQYDri9kgHI2oWUPqLjjZ6zWMgMr31BzEWo0lJYODLKx6
         YLzyYz/6E9+GFO03AntDOBjiHdIi1DCoTovS9czL/CDKqZBVjMVddWkU2eyilk6iW9gT
         /EBIYNEWLailUQWziT9Nr+qEKwCHdCcFPabXOh/qaLac/ClyCJbJ2tah4QDx03VFc06U
         kRcO+p4t4S9s3H68izCdU0ncZ4PURrU0aNjDGDJaK+ugKpHWEV21OUq0XZ/gNHKm6RHq
         AGFEcuwFW1osCUvqOtXN+SMbzZNmiQWjWmC0LXzQRZtzpkxyYDebeJg3Qbj4A89sOT8p
         SpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597059; x=1770201859;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP54E5Zozvp+1GAPNgjDcxymFAEsnkay7BW+MQRPQZQ=;
        b=UwDCT1M6DxH94LPtcCAA65X+M7EFrRMk2DARAatyBBDhpt9McHGVPAK5aVh+x0X50l
         giLTW+sB2eRuKGwqXyqbxhuycNetk7DneNfP/wuSN3sIyTNnVY00sY0wDCejseoFOCVQ
         +wRSXAO/xkNA86Fu3SZVHZf7ZAdrDkpw865HGyMVGWWrYGtijhkABdUUCVrYAMoOSBes
         daIIEjFj4450wsxFsOMsx6NljT3N5WnJ/RMf0K3kadtiuvjM5HLZXiXZw61kU5C4mOnE
         59YruLUQkryOvx2n0NUs0kaTl1DUhaqbj8Xo8sj3nYAJVUg0D99i9s1It9b98Oc1hqTa
         seuA==
X-Forwarded-Encrypted: i=1; AJvYcCU/V6cML7Nak8l6tmwq++3Kk3gJZmZ//yp4IBqCzONbnBLeQUPF82taPgjkSswscsqMp7nstMTFkag1zd4+nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMAvP3YFU5W5dF5mAMufNFCZ/MPyqewbNzXdIafORzDquYHopI
	LdEWYBZP5BclRS2f5biDqHDBnhbZ8l7mIwyLgBxJpQJG4yw+CpmpIo7y
X-Gm-Gg: AZuq6aLkk7iOQkQuUR9evicw0F0NBNYo4Ckv+gL2TIi5nlhz8kuEC1x1B2hXIQXBaQn
	H8/LWRCm65I9OGNNomT+LCpQc+Q9Xv8TL23Cc8/L4SbGUpM26GCc4uG9U7sWCSgFMChu2gp0nn6
	Oy8tPDuPEUjDjEbuRe5dLuBn8HDygys0FxIBhwZqaqhgHf7UmIw+Caqs9gLm3zkvnMX0G+pkRLW
	qI3GEhrFeYHrrm/vrs+vHkAomA/EItra54kj/e+71lrn+PXfxEMvXUrBR9SUpIikC60+vpbCjlo
	7vew+lJOjMosISkGFRO2TNP720LAf6F+Xnt9RBpIaUNItIrnvkCPuV54b++CHwChwv9pbeUmPKo
	7l/RkL2AovHfCP3tciASXbQf+xs5suUxSe8ixO/0H7cImzZziacDLphrB7fUq87fsVDtr3hhNMb
	YuCvtYoG/B4k0GxIMBm6UidfQyYWjGFA==
X-Received: by 2002:a05:600c:4746:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-48069c5547amr64307945e9.30.1769597058510;
        Wed, 28 Jan 2026 02:44:18 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce564f9sm57099265e9.14.2026.01.28.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:44:18 -0800 (PST)
Message-ID: <be27fa4404511cdf65a9a0f212653a7f1fcd86b6.camel@gmail.com>
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Konstantin Ryabitsev <mricon@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Thomas
 Gleixner	 <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>,  Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>,  Kent Gustavsson	 <kent@minoris.se>, Gustavo
 Silva <gustavograzs@gmail.com>, Nishant Malpani	
 <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Date: Wed, 28 Jan 2026 10:45:01 +0000
In-Reply-To: <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	 <20260123113708.416727-19-bigeasy@linutronix.de>
	 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
	 <20260126081510.jr8Rp6R7@linutronix.de>
	 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
	 <20260126101034.lnGGQmUD@linutronix.de>
	 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
	 <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2026-01-26 at 09:29 -0500, Konstantin Ryabitsev wrote:
> On Mon, Jan 26, 2026 at 01:01:02PM +0200, Andy Shevchenko wrote:
> > > I lose it on the next if I update patches in tree and re-export them.=
=20
> >=20
> > I don't understand this, sorry. Can you provide a step-by-step example?
> > Do you mean that you are taking previous version from the list and reap=
plying
> > it via `git am`? But shouldn't `b4` take care of that as long as it kno=
ws the
> > Change-ID and it matches?
>=20
> That's not the intended workflow -- the series is kept as a branch in you=
r
> local tree and any updates happen to that branch, so any entries in a com=
mit
> falling under "---" will persist across revisions.
>=20

Hi Konstantin,

Since I have you here, I might ask about something that I'm not sure how to=
 handle. Might be dumb
but here it goes. One problem is when I send v1 based on a branch and when =
I'm starting to work on
v2 that branch was force-updated and I want to base my v2 on it. Is there a=
ny good way to handle
this?


What I currently do is more or less:

git cat-file -p $COVER_SHA
git reset --hard origin/branch
git commit --allow-empty (and past all the cover with b4 metadata)
// apply my series patches.

Thx!
- Nuno S=C3=A1
>=20
