Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A83A4F47
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123742; cv=none; b=sHbdqHZ+SDDvxj2Hqo0kXjYBsoVR4uTTLH+p3CvcmPigJpQ13KJFjYNkHRfz2d4oKFPEEJg41gIhPskgznr7iyLrvOHTcyj/Df1qfHS5k6VsGrH80JwGAqCgjcittNeULuMkqhYZS3MpgvGiT9oFm3aLyVpi44ZtXso6qUo+bRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123742; c=relaxed/simple;
	bh=pHtr1wFX2vlw94GF4+q9U5iR5hkxAW8i1a9w0SHfds4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JyqoN4MEZnja3l4e2ycKSz/jjmjkCzhdnPN39OlhgDX09IHoEV7ZLCwUkZ9T6kNzoMuTTpHHnprOh6c0b1hhfTrBcfIvXUsN4W4GuQIcszlCsFexUMiJ0ynfVnhqyfMBcUnbwbDxkxa0m560eTag98CxC9lsrjsbnhF/VHtSz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xFBX8QjQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xFBX8QjQ"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782123739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHtr1wFX2vlw94GF4+q9U5iR5hkxAW8i1a9w0SHfds4=;
	b=xFBX8QjQkR1DuMTzdeEHyFPkReDNd8a0xqRNXzbhW2PNWYQLBiz3Vg5/m6+gWKKPdabSKh
	9g/sRL6uIX1n7OiIfiX9/EE1MGa6ImtZs+LEmKW4AXs0a4Ix+B/8jZTHb5z734MskIZN2E
	uoBAi3mv2x2hHw1LB3ARsY0xZiKP7qY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:22:17 +0000
Message-Id: <DJFI52XOQEPO.AH00UF550LWN@linux.dev>
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 09/13] net/funeth: Switch to higher-level allocator
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-9-31f31367d420@google.com>
 <20260622101153.C08741F000E9@smtp.kernel.org>
In-Reply-To: <20260622101153.C08741F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 10:11 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message logic regarding __alloc_pages_node and allo=
c_pages_node is inverted.
> --
>
> commit ab883602f87dc726f65726ac01fce73a498907b3
> Author: Brendan Jackman <jackmanb@google.com>
>
> net/funeth: Switch to higher-level allocator
>
> This commit replaces __alloc_pages_node() with alloc_pages_node() in the
> funeth driver.
>
>> The difference between __alloc_pages_node() and alloc_pages_node() is
>> that the former allows you to pass NUMA_NO_NODE.
>>=20
>> The former is going away and the latter works fine here so switch over.
>
> [Severity: Medium]
> Is this description inverted? Looking at include/linux/gfp.h, it is
> alloc_pages_node() that safely handles passing NUMA_NO_NODE by checking
> if (nid =3D=3D NUMA_NO_NODE). On the other hand, __alloc_pages_node() con=
tains a
> VM_BUG_ON() which strictly prevents passing NUMA_NO_NODE (-1).
>
> The code change itself appears correct since the node variable can be -1 =
here,
> but could the commit message be updated to accurately reflect which funct=
ion
> handles NUMA_NO_NODE?


Repeating myself[0] as this patch has a different CC list from the others:

Sashiko is correct, the commit message says "former" but it should say
"latter".

[0] https://lore.kernel.org/all/DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev/
