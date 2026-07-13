Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CE33B6F4;
	Mon, 13 Jul 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960563; cv=none; b=taCG++t0lp/SKpkYqmWgGmPe72h9nphbbPTCYQd78gnP5y/SXS3GS94rNSBicEE7Wfq3IMN3LcwFEi6EIXdFy3TGEixsHKFuMDIOGrRqoqZeYroCSap5dyKY6NuEefRaqJUE29TIPSW9ydCfcYsoP7gxRJogAoAVVfE6bFRr7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960563; c=relaxed/simple;
	bh=yRPyrtQaOLd9COn8sv5ADcnnOp/BEaTfGAlyXEAZSo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPnsd1XW+o5gFxqHthFQ6F0Sdlm0ychqVMVsItm3y9C/vHyEDtSWwGycti+5MIa+1I6wzFTxWd4CnvOZF/uQLhbmyhA+KTernk90xPF8QOkchJFR9UfYAVgX9sm6sL1yAG3TiKB1H5xkncPuLJ/mbYLE0B4SImW8upzbZDB8K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obx6Tkms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obx6Tkms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A381F000E9;
	Mon, 13 Jul 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960562;
	bh=yRPyrtQaOLd9COn8sv5ADcnnOp/BEaTfGAlyXEAZSo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Obx6TkmsSssAInEyPTzVsGrHYu63MyyyvLI/KLJXOPeN5ILQPiKuh25XCBIfr3IfC
	 knHxBaXUMwp029rpzJukgH+URYG/UyybB7hODhK4YXyMDy3WxdyHwzuL/H2QAznti1
	 SGv02ruPklnPa4kuiksfAWmU0TB/vs8EMij53UamdHrXgWdiQc1Ik4ovvW2Ws8g4Ac
	 1E2o4dXlntrHknVRcmFWv5g6/rD+4Y5bwX+W5C/CWfnEJPyKx9nyNsOTYHpt0gbRe2
	 G3SZdtpwLehgMWJzjtRacRiM7K5Wm7o7cEVNW7GwMAGGlpWZDlbwHbfdAQc2R3GMyq
	 jpUX+RbAVykoQ==
Message-ID: <0cf0a46b-bdc6-4abb-802e-1c9a3aeeb949@kernel.org>
Date: Tue, 14 Jul 2026 01:35:50 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
To: Zi Yan <ziy@nvidia.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
 <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
 <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qyDoBBKI4CFV1ErawcmtQ8PZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qyDoBBKI4CFV1ErawcmtQ8PZ
Content-Type: multipart/mixed; boundary="------------Fq0CsMv87TD2rsvZ09eDJYci";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Zi Yan <ziy@nvidia.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Message-ID: <0cf0a46b-bdc6-4abb-802e-1c9a3aeeb949@kernel.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
 <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
 <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
In-Reply-To: <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>

--------------Fq0CsMv87TD2rsvZ09eDJYci
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/10/26 11:14 PM, Zi Yan wrote:
> On Fri Jul 10, 2026 at 8:40 AM EDT, Vlastimil Babka (SUSE) wrote:
>> On 7/10/26 12:42, Brendan Jackman wrote:
>>> As discussed in the linked patch, the there is some inconsistency bet=
ween
>>> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" i=
s
>>> used in the public API it seems to have more mindshare so do that.
>>>
>>> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
>>>
>>> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714=
e19d3@google.com/
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Naming things is hard. Maybe it should have all been called "nospin". =
I
>> don't know anymore :)
>> _nolock() functions and ALLOC_NOLOCK are part of API, FPI_ is internal=
 so
>> it's not that urgent. Furthermore:
>=20
> I had a similar concern when reading ALLOC_TRYLOCK -> ALLOC_NOLOCK[1],
> since the name is _NOLOCK, but the comment says spin_trylock.
>=20
> I agree that "nospin" is better and less confusing. But whether we want=

> to churn it again, TBD. :)
>=20
> [1] https://lore.kernel.org/all/DJOZN5H048UX.1ZVSFD48QZN05@nvidia.com/

Agreed, "nospin" is a better name!

At some point I realized "NOLOCK? well, we're using locks, but without
spinning. should be NOSPIN?", then thought it's bit late to change the
name without churn :)

--=20
Cheers,
Harry / Hyeonggon


--------------Fq0CsMv87TD2rsvZ09eDJYci--

--------------qyDoBBKI4CFV1ErawcmtQ8PZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalUT5wAKCRCGXBN6rc5S
1h/7AQCF5kASlmfGZSwsQDL+wbn4ZkmiaE9YxS5ntJj8j7Ik6wEA/deiUAuWtErF
6frBc+P/wyv/2HHN8j9qaE1Wo6yDZg0=
=iyK0
-----END PGP SIGNATURE-----

--------------qyDoBBKI4CFV1ErawcmtQ8PZ--
