Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9824293C
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657145; cv=none; b=fIG5U/+DlZd6svJMFkcyD8uvoC2OoMmeEVriwrh7Zsyfgb/dDAyckBjI7gV02hEUeytLj1WxDeHM1bdCaZtrHmPCWmMtaOVJTFgQLn2hbonpltHiqmMIsh9uUtCOB2VpL5V1yeMJA+yCJ6JEDl5KWbi9idwrGv+wh451h0RbEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657145; c=relaxed/simple;
	bh=yDGftTYnH+93RsBLui3JWZl61TFhKW7rk/zGdxHAWo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jm4lR7WpyhoeTHQ8fjw8//Ooq56+tQ+PTxrXuWuVDMVBMsDMSN3tWZ1HePX3nbKubcA3FGga0lj9nkTqvuBm0G/BNQFjfWsBRlrpDq370s2+/4WiO9AqaSWMWjsEli7bbQwn435BmxcNtmCnO1n2SUlEj/pDSKJ8SjRhq4TWdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=A3rIBsn6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="A3rIBsn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772657097; x=1773261897; i=spasswolf@web.de;
	bh=SwW0QRa8Prd0fOKLBrX+aNZVgeiyzzMgfPUTqm4WHFk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A3rIBsn6LrOzoaItpdfmdyOD4uh9miJEj5eRYMdXSZy3fJs3Nf6WpTX+M+UDuuRD
	 eSFaDcLTS2bHiYjSZYHD9BZIopY1ACYrXT+Ia/zn09Wxj4rgEeb8eagLKtlAjVXaa
	 iTfKQZ+OI1sNzWDitPCP50y6vCu0zbg/Ss6Y0KTwERoXoAaG3G7XcFng99f8HNt7W
	 pbGiWy/mYEYKlaQlHC7w4oJ/8g14lv6CyY9RSsoPdD6zoTDjKr9wq7EH1NNYGl3Jq
	 XiG8mR5mcDwutPgh3jjL1RudM185VXc4XxORvJkfJi+QV99z37GVJ5bjPr1V/IDiP
	 yHpF0D4sra5LWYGiGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1vOH1L46Ep-00qWlZ; Wed, 04
 Mar 2026 21:44:57 +0100
Message-ID: <9541893b588ef644a06cf01bb65005e9efcb3427.camel@web.de>
Subject: Re: rtmutex deadlock and memory corruption when running gcc
 testsuite in next-20260303
From: Bert Karwatzki <spasswolf@web.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, David Hildenbrand <david@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, Harry Yoo	 <harry.yoo@oracle.com>, Hao Li
 <hao.li@linux.dev>, spasswolf@web.de
Date: Wed, 04 Mar 2026 21:44:10 +0100
In-Reply-To: <f4591e7b-d07a-402a-a051-8ff12b0ccc09@kernel.org>
References: <20260303222127.2992-1-spasswolf@web.de>
		 <f4591e7b-d07a-402a-a051-8ff12b0ccc09@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vBfk+6eHnvkFjCm4W1479QZRkiCXWQp0DJgvC9H2S0hbQoIBUMU
 jWMMbywboyAeFdqZQEDjMsTFf+2Ve6KXxm9g7gV2ikCNbsHJb0oSHokgxWcDx9O2c+mp2vN
 ftIiH+n3khejj31qifmpxUXD0PWgyx12dp27czXQBbWnTv3QIZ6liXcYOV8UUT4M97k6xeK
 gplMk/Cu0OL76uBkiBcwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:01xl6gTtm4U=;qPYTUtAxFs3WPK7pHi/LUS4zC/O
 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
 XrX6x44lUJGd2dQwixAIJxegPHt3S

Am Mittwoch, dem 04.03.2026 um 15:15 +0100 schrieb Vlastimil Babka (SUSE):
> On 3/3/26 11:21 PM, Bert Karwatzki wrote:
> > I tried building gcc-14 from the debian repositories (fetched via apt-=
get=20
> > source gcc-14) on my new and shiny zen5 machine (Cpu: "AMD Ryzen 9 995=
0X=20
> > 16-Core Processor) running debian stable/trixie and linux-next-2026030=
3=20
> > (PREEMPT_RT=3Dy) with the following command:
>=20
> It's probably my fault, sorry about that.
> Specifically commit 666a739089c from slab/for-next-fixes.
> Does the following fix it? The fixed commit was meanwhile
> queued so hopefully will be in next-20260304
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 740edbad0475..1871c5ef354a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4610,6 +4610,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, str=
uct slub_percpu_sheaves *pcs,
>  	}
> =20
>  	local_unlock(&s->cpu_sheaves->lock);
> +	pcs =3D NULL;
> =20
>  	if (!allow_spin)
>  		return NULL;
>=20
>=20

Yes, this seem to fix the issue (two testruns without errors). So the prob=
lem was __pcs_replace_empty_main()
returning a non-NULL pcs in the case where it can't take the lock (&s->cpu=
_sheaves->lock) and jumps to
barn_put:.

Bert Karwatzki
