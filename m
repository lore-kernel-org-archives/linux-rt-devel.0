Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9303EB0E6
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813881; cv=none; b=QolzTnIAjZEPxobpTR+5A0ZxPRMYu9R24A/eTyybSFzQCmEzc/u5TNsykaKvpyNJaTmvakX83dP7uiW5rzscX32I4PSHvQQogdTi7KurAynfy4EMDF+Xb6X7GcHs0vkyeR8fleMxCLuM6DwqstfJv1ZfLUnRd/U2fVw+JlyNLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813881; c=relaxed/simple;
	bh=tYdqggSTU0eUTRUtG2ICREbhztwMifrsi84mldUuOdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PAZJQDHHs5slaBCZUcWqDHXbf1mlxIbPXyvWYnk325If+nFZZ8vgI9qPUeuqEapEhnWAxG2sHv48Zb291jI0rkP9PGNUu0J8L3ta4P0L5XSxnvyTelDzcx7FPm94S2rQsrne0bOGItuEjOZvrxt0Pth23cu1toM0a8bJbSoxbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbxxYJwb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbxxYJwb"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782813877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/o3Bb//lZA6jxEu1tVIEz7VRsC6xt3cTJJ+Aag4plFs=;
	b=WbxxYJwbA+X92xFrlfqDZ1XKBS2fIteWH4gIxBeQ6uiGbxdhPP+JKauh+PsVnrkgU7TtG3
	18XMQmlePJJmJ1+9pL5TC20jTIHpeHBhtCmdZAehF4BCeGenjAjldoWbJfQJunY2UZM3ah
	erQoZ2nlVdLkDqylbRnRUVJE8+BScTs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 10:04:27 +0000
Message-Id: <DJMARS53FLR0.HUOA8X4VT5E2@linux.dev>
Cc: <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 16/16] mm: remove the __GFP_NO_OBJ_EXT flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-16-57bef0eadbc2@google.com>
 <20260629160239.334E71F000E9@smtp.kernel.org>
In-Reply-To: <20260629160239.334E71F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 29, 2026 at 4:02 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Incomplete removal of `__GFP_NO_OBJ_EXT` flag leaves the bit r=
eserved in the core kernel.
> --
>
> commit d2006cc547e302003b4c27943f81bc40cdd90223
> Author: Brendan Jackman <jackmanb@google.com>
>
> mm: remove the __GFP_NO_OBJ_EXT flag
>
> This commit removes the __GFP_NO_OBJ_EXT flag from the tools copy of
> gfp_types.h. Its previous users have been converted to use
> SLAB_ALLOC_NO_RECURSE or ALLOC_NO_CODETAG instead.
>
>> diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_t=
ypes.h
>> index 6c75df30a281d..a93b8bd200b76 100644
>> --- a/tools/include/linux/gfp_types.h
>> +++ b/tools/include/linux/gfp_types.h
>> @@ -55,7 +55,6 @@ enum {
>>  #ifdef CONFIG_LOCKDEP
>>  	___GFP_NOLOCKDEP_BIT,
>>  #endif
>> -	___GFP_NO_OBJ_EXT_BIT,
>
> [Severity: Medium]
> Is it possible that the core kernel header updates were missed? The
> changes in this patch only modify the tools copy of the header, which
> causes it to diverge from the actual kernel definitions.
>
> Looking at include/linux/gfp_types.h, ___GFP_NO_OBJ_EXT_BIT remains
> reserved in the core kernel.=20

LOL, Sashiko is correct, I did not actually delete __GFP_NO_OBJ_EXT in
this patch.
