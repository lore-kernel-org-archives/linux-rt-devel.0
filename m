Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593633F8ED3;
	Fri, 26 Jun 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488710; cv=none; b=t7BdWtI3hlzthPi1msgeLI/LTSEH+AHkWvc1hTINzslkPzaiprEACA8Hn6wzVrgOUVkH4q5mdK06m4x47awVPgs7a4KV3P3QQIPjrwN1HqZc1REvyJg+DTMF9UPmt4GLOCsJv9VH8MC8XOGa+uhQxhHAvoJV7AItp6MVZuwwhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488710; c=relaxed/simple;
	bh=KKlH/8SEamUqGyyjWbc5rFZsLVr+VsxGBvdwYg4b4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOzioBfz9ebY9l50ym53ddQhNjTgT8140u7c4EH5YuNk6FjYgNKZVAzhKdrPQl6z0Nfs26ar6RQojsCWVgfCK7i0Dbk5uALwHBKtWFOkkqm6jA/XR5qBs7U+0BylX6RA2ZmVasEwg9seXVbvx0fE15qIMFQ0iQ/82oeo2mRrCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3yjhDRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3yjhDRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2BF1F01561;
	Fri, 26 Jun 2026 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782488705;
	bh=YoE9n7g3JaL94VUoMaa+5nIfgKgOXYELQGwVyrlOQDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3yjhDRKri5OqFVXbZ0Pnd8TmyxIp0+JQNaSAASUVkDKRZK3F5aD/cj7Mdk/lyWzj
	 oeHeNrHk3b9lY6ssLUYcNsr1C4BN1AOrUsuDIno7QiCHl3IjGf7DS0dbuV3/2l2mk+
	 UtP9/QlRgQLGiCNzbtpjAPN4TeSHLpLMz15UB5UHXey0pHTIrqJS4nb2G+z3zqPW5e
	 9Crvxz22lYIWw73PxU4qRqzXUz5kygn7vKP88lseWFRZ1TPjU6KSSxHB/37hx6fL2l
	 ii86j4F/28QrKlTXxLv8tHhilaDvOGDQvbBcOtaF047os8dt+0DfMKKJl7llUwUCQk
	 7m+eXmrvm2SsA==
Date: Fri, 26 Jun 2026 16:44:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: riscv: Add generic CBQRI controller
 binding
Message-ID: <20260626-immobile-staining-c825a86bd613@spud>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-7-2f8049fd902b@kernel.org>
 <20260625-cupbearer-failing-9ce0abf97b93@spud>
 <aj1_0AnIBk8_xoDd@gen8>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/zmDCd3AvwrgXHjE"
Content-Disposition: inline
In-Reply-To: <aj1_0AnIBk8_xoDd@gen8>


--/zmDCd3AvwrgXHjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 12:21:52PM -0700, Drew Fustini wrote:
> On Thu, Jun 25, 2026 at 05:19:28PM +0100, Conor Dooley wrote:
> > On Wed, Jun 24, 2026 at 06:38:35PM -0700, Drew Fustini wrote:
> > > Document the generic compatibles for capacity and bandwidth controlle=
rs
> > > that implement the RISC-V CBQRI specification. The binding also
> > > describes the common riscv,cbqri-rcid and riscv,cbqri-mcid properties,
> > > and the optional riscv,cbqri-cache phandle that links a capacity
> > > controller to the cache whose capacity it allocates.
> > >=20
> > > Assisted-by: Claude:claude-opus-4-8
> > > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > ---
> > >  .../devicetree/bindings/riscv/riscv,cbqri.yaml     | 97 ++++++++++++=
++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 98 insertions(+)
>=20
> Thanks for the review.
>=20
> [..]
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - description: Tenstorrent Ascalon Shared Cache
> > > +            const: tenstorrent,ascalon-sc-cbqri
> > > +          - const: riscv,cbqri-capacity-controller
> > > +      - enum:
> > > +          - riscv,cbqri-capacity-controller
> > > +          - riscv,cbqri-bandwidth-controller
> >=20
> > Please modify this, as has been done for other riscv spec related
> > bindings, to let people get away without using device-specific
> > compatibles.
> >=20
> > In this case, you can just delete the first entry from this enum, since
> > it already has a user and only have to implement this feedback for the
> > second entry.
>=20
> Would this work?
>=20
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - tenstorrent,ascalon-sc-cbqri # Tenstorrent Ascalon Shared=
 Cache
>           - const: riscv,cbqri-capacity-controller
>       - items:
>           - {}
>           - const: riscv,cbqri-bandwidth-controller


Should do, yes. I question the need for a comment though, seems pretty
evident from the compatible what it is.

> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: tenstorrent,ascalon-sc-cbqri
> > > +    then:
> > > +      required:
> > > +        - riscv,cbqri-rcid
> > > +        - riscv,cbqri-cache
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    l2_cache: l2-cache {
> > > +        compatible =3D "cache";
> > > +        cache-level =3D <2>;
> > > +        cache-unified;
> > > +        cache-size =3D <0xc00000>;
> > > +        cache-sets =3D <512>;
> > > +        cache-block-size =3D <64>;
> > > +    };
> > > +
> > > +    cache-controller@a21a00c0 {
> > > +        compatible =3D "tenstorrent,ascalon-sc-cbqri",
> > > +                     "riscv,cbqri-capacity-controller";
> >=20
> > Is this or is this not a cache controller?
> > The compatible and fact that the property points to an actual cache
> > controller suggests that this is not.
>=20
> Good point. This nodes represents just the QoS interface (CBQRI) and
> should not use that node name. 'qos-controller' seems like it would be
> more appropriate but that has no precedent. What do you think?

Sure.


--/zmDCd3AvwrgXHjE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6eeAAKCRB4tDGHoIJi
0j45AQDa9hIH0IvDEkhDSJ4irWoqKAUinH30Au/Pl3yikbPiWgD8CfQij41pcGKQ
lnHL1Q1xyI46Q5kOGm2ZVr23WQjr/wo=
=JJMy
-----END PGP SIGNATURE-----

--/zmDCd3AvwrgXHjE--
