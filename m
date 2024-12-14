Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557D3EA76
	for <linux-rt-devel@lists.linux.dev>; Sat, 14 Dec 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201673; cv=none; b=oAu3ZQNq8gjrhEbNMlp8tjUFNGCCds07fJYkjhADatpHSwYUv0VcIQV17TRfOw5WzUaUDmZMlqTyVem0UhJHb3U295V3YjqRMRByc67ynofirPg8sah9iCqdNe8sGYYyVC3FmUP7u+mY9l3Os55HAoRNDeOzT7AUF36H6vpd47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201673; c=relaxed/simple;
	bh=g7rTlp2Fy0rmh8iTu37cPNHXE5zBs2vgpiuv/ttvAcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nVm5l4Is0qPTlRR7BJ5tM2Dc9J7y+tC7QahN7KCmcx0SOy3DZueXyGJHnykjQq/DzzNcuT1yhHAwp3iK+TqVUlOGK/TvfORcZEBi1UA2RZsql0wcqvrYtq1WOVU7vSrRy0Db+qLCa+9IZzKB5DkgNkotDoOoaly0g044qrNVodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-280-3Kd5c3ElMVu5EUN2SKtuRQ-1; Sat, 14 Dec 2024 18:41:08 +0000
X-MC-Unique: 3Kd5c3ElMVu5EUN2SKtuRQ-1
X-Mimecast-MFC-AGG-ID: 3Kd5c3ElMVu5EUN2SKtuRQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 14 Dec
 2024 18:40:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 14 Dec 2024 18:40:11 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, "Ard
 Biesheuvel" <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, "Jason
 Baron" <jbaron@akamai.com>, Josh Poimboeuf <jpoimboe@kernel.org>, "Linus
 Walleij" <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
Thread-Topic: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
Thread-Index: AQHbSx10HM4hb1GiOk+xX2rPfGcyA7LmGAAw
Date: Sat, 14 Dec 2024 18:40:11 +0000
Message-ID: <d54e11cf3f4d4216b5cecf29b761cd45@AcuMS.aculab.com>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-4-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-4-arnd@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m80m-wpJNwTdKWj5lge6Jr0iWQwsLc1PUWsnWlJjlTE_1734201667
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann
> Sent: 10 December 2024 16:06
...
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.

'Picking at nits' 'highmem' support was needed for systems with 4GB of RAM
in order to use more than 3GB or 3.5GB (depending on the bios) because
of the physical addresses that are reserved for PCI (and other MMIO).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

